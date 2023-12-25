#include "bits/stdc++.h"

using namespace std;

using i64 = int64_t;
using f64 = long double;

template <class F = i64>
struct Dinitz {
	struct Edge {
		int v, index;
		F capacity;
	};

	int n;
	vector<vector<Edge>> a;

	Dinitz(int n): n(n) {
		a.resize(n);
	}

	pair<int, int> add_edge(int u, int v, F capacity, F reverse_capacity = 0) {
		assert(min(capacity, reverse_capacity) >= 0);
		a[u].push_back({v, (int)a[v].size(), capacity});
		a[v].push_back({u, (int)a[u].size() - 1, reverse_capacity});
		return make_pair(u, (int)a[u].size() - 1);
	}

	F get_flow(pair<int, int> edge) {
		const Edge& e = a[edge.first][edge.second];
		return a[e.v][e.index].capacity;
	}

	vector<int> level, pointer;

	bool bfs(int s, int t) {
		level = pointer = vector<int>(n);
		level[s] = 1;
		queue<int> q;
		q.push(s);
		while (!q.empty()) {
			int u = q.front();
			q.pop();
			for (auto& e : a[u]) {
				if (e.capacity > 0 && level[e.v] == 0) {
					q.push(e.v);
					level[e.v] = level[u] + 1;
					if (e.v == t) {
						return true;
					}
				}
			}
		}
		return false;
	}

	F dfs(int u, int t, F current_flow) {
		if (u == t) {
			return current_flow;
		}
		for (int& i = pointer[u]; i < (int)a[u].size(); ++i) {
			Edge& e = a[u][i];
			if (level[e.v] != level[u] + 1 || e.capacity == 0) {
				continue;
			}
			F next_flow = dfs(e.v, t, min(current_flow, e.capacity));
			if (next_flow > 0) {
				e.capacity -= next_flow;
				a[e.v][e.index].capacity += next_flow;
				return next_flow;
			}
		}
		return 0;
	}

	F compute_flow(int s, int t) {
		F flow = 0;
		while (bfs(s, t)) {
			F next_flow;
			do {
				next_flow = dfs(s, t, numeric_limits<F>::max());
				flow += next_flow;
			} while (next_flow > 0);
		}
		return flow;
	}

	vector<pair<int, int>> compute_cut(vector<pair<int, int>> edges) {
		vector<pair<int, int>> answer;
		for (auto& [u, index] : edges) {
			auto e = a[u][index];
			if (level[u] != 0 && level[e.v] == 0 && e.capacity == 0) {
				answer.emplace_back(u, e.v);
			}
		}
		return answer;
	}
};

int main() {
    int n;
    cin >> n;
    vector<pair<int, int>> edges;
    Dinitz network(n);
    for (int i = 0; i < n; ++i) {
        int d;
        cin >> d;
        for (int j = 0; j < d; ++j) {
            int to;
            cin >> to;
            to--;
            edges.push_back(network.add_edge(i, to, 1));
            edges.push_back(network.add_edge(to, i, 1));
        }
    }
    auto flow = network.compute_flow(202, 3);
    cout << flow << '\n';
    auto cut = network.compute_cut(edges);
    for (auto [u, v] : cut) {
        cout << u+1 << ' ' << v+1 << '\n';
    }
}
