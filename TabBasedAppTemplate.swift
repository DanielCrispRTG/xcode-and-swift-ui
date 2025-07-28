import SwiftUI

// MARK: - Tab-Based App Template
// A complete template for a tab-based iOS app with common tabs

struct TabBasedAppTemplate: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(.blue)
    }
}

// MARK: - Home View
struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Welcome Back!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Here's what's happening today")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    // Quick Actions
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                        QuickActionCard(icon: "plus.circle.fill", title: "Add New", color: .blue)
                        QuickActionCard(icon: "chart.bar.fill", title: "Analytics", color: .green)
                        QuickActionCard(icon: "bell.fill", title: "Notifications", color: .orange)
                        QuickActionCard(icon: "gear", title: "Settings", color: .gray)
                    }
                    .padding(.horizontal)
                    
                    // Recent Items
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Recent Activity")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(0..<5) { index in
                            RecentItemRow(title: "Item \(index + 1)", subtitle: "Description for item \(index + 1)")
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Search View
struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                
                if searchText.isEmpty {
                    Spacer()
                    VStack(spacing: 20) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.secondary)
                        
                        Text("Start searching")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Text("Enter keywords to find what you're looking for")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                } else {
                    List {
                        ForEach(0..<10) { index in
                            SearchResultRow(title: "Result \(index + 1)", subtitle: "Matching: \(searchText)")
                        }
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
}

// MARK: - Favorites View
struct FavoritesView: View {
    @State private var favorites: [String] = ["Favorite 1", "Favorite 2", "Favorite 3"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favorites, id: \.self) { favorite in
                    FavoriteRow(title: favorite)
                }
                .onDelete(perform: deleteFavorites)
            }
            .navigationTitle("Favorites")
            .toolbar {
                EditButton()
            }
        }
    }
    
    func deleteFavorites(offsets: IndexSet) {
        favorites.remove(atOffsets: offsets)
    }
}

// MARK: - Profile View
struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("John Doe")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("john.doe@example.com")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                }
                
                Section("Settings") {
                    SettingsRow(icon: "bell", title: "Notifications", showBadge: true)
                    SettingsRow(icon: "lock", title: "Privacy & Security")
                    SettingsRow(icon: "creditcard", title: "Payment Methods")
                    SettingsRow(icon: "questionmark.circle", title: "Help & Support")
                }
                
                Section("App") {
                    SettingsRow(icon: "star", title: "Rate App")
                    SettingsRow(icon: "square.and.arrow.up", title: "Share App")
                    SettingsRow(icon: "info.circle", title: "About")
                }
                
                Section {
                    Button("Sign Out") {
                        // Handle sign out
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Profile")
        }
    }
}

// MARK: - Supporting Views
struct QuickActionCard: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct RecentItemRow: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "doc.fill")
                        .foregroundColor(.blue)
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("2h ago")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search...", text: $text)
            
            if !text.isEmpty {
                Button("Cancel") {
                    text = ""
                }
                .foregroundColor(.blue)
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct SearchResultRow: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text(subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

struct FavoriteRow: View {
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
            
            Text(title)
                .font(.subheadline)
            
            Spacer()
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    var showBadge: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 20)
                .foregroundColor(.blue)
            
            Text(title)
            
            Spacer()
            
            if showBadge {
                Circle()
                    .fill(Color.red)
                    .frame(width: 8, height: 8)
            }
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    TabBasedAppTemplate()
}
