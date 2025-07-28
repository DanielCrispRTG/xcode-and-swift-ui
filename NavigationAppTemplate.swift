import SwiftUI

// MARK: - Navigation-Based App Template
// Complete navigation stack template with master-detail flow

struct NavigationAppTemplate: View {
    var body: some View {
        NavigationView {
            MasterListView()
                .navigationTitle("Items")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddItemView()) {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
        .navigationViewStyle(.stack) // Ensures single view on iPhone
    }
}

// MARK: - Master List View
struct MasterListView: View {
    @State private var items = SampleData.items
    @State private var searchText = ""
    @State private var selectedCategory: ItemCategory = .all
    
    enum ItemCategory: String, CaseIterable {
        case all = "All"
        case work = "Work"
        case personal = "Personal"
        case important = "Important"
        
        var icon: String {
            switch self {
            case .all: return "list.bullet"
            case .work: return "briefcase.fill"
            case .personal: return "person.fill"
            case .important: return "star.fill"
            }
        }
    }
    
    var filteredItems: [Item] {
        let categoryFiltered = selectedCategory == .all ? items : items.filter { $0.category == selectedCategory.rawValue }
        
        if searchText.isEmpty {
            return categoryFiltered
        } else {
            return categoryFiltered.filter { 
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Search Bar
            SearchBarView(text: $searchText)
                .padding(.horizontal)
                .padding(.top, 8)
            
            // Category Filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(ItemCategory.allCases, id: \.self) { category in
                        CategoryChip(
                            category: category,
                            isSelected: selectedCategory == category,
                            action: { selectedCategory = category }
                        )
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 8)
            
            // Items List
            List {
                ForEach(filteredItems) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        ItemRowView(item: item)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
            .refreshable {
                // Simulate refresh
                await refreshData()
            }
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func refreshData() async {
        // Simulate network call
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
}

// MARK: - Detail View
struct DetailView: View {
    let item: Item
    @State private var showingEditView = false
    @State private var showingShareSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Image
                AsyncImage(url: URL(string: item.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                        )
                }
                .frame(height: 200)
                .clipped()
                .cornerRadius(12)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    // Title and Category
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        HStack {
                            CategoryBadge(category: item.category)
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Image(systemName: "clock")
                                Text(item.createdAt, style: .relative)
                            }
                            .font(.caption)
                            .foregroundColor(.secondary)
                        }
                    }
                    
                    Divider()
                    
                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.headline)
                        
                        Text(item.description)
                            .font(.body)
                            .lineSpacing(4)
                    }
                    
                    // Metadata
                    if !item.tags.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Tags")
                                .font(.headline)
                            
                            FlowLayout(spacing: 8) {
                                ForEach(item.tags, id: \.self) { tag in
                                    TagView(tag: tag)
                                }
                            }
                        }
                    }
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        Button(action: { showingShareSheet = true }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        
                        Button(action: { showingEditView = true }) {
                            HStack {
                                Image(systemName: "pencil")
                                Text("Edit")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: { showingEditView = true }) {
                        Label("Edit", systemImage: "pencil")
                    }
                    
                    Button(action: { showingShareSheet = true }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    
                    Button(role: .destructive, action: {}) {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showingEditView) {
            EditItemView(item: item)
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(items: [item.title, item.description])
        }
    }
}

// MARK: - Add Item View
struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var description = ""
    @State private var selectedCategory = "Personal"
    @State private var tags: [String] = []
    @State private var newTag = ""
    
    let categories = ["Work", "Personal", "Important"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Basic Information") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section("Category") {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Tags") {
                    HStack {
                        TextField("Add tag", text: $newTag)
                        
                        Button("Add") {
                            if !newTag.isEmpty && !tags.contains(newTag) {
                                tags.append(newTag)
                                newTag = ""
                            }
                        }
                        .disabled(newTag.isEmpty)
                    }
                    
                    if !tags.isEmpty {
                        FlowLayout(spacing: 8) {
                            ForEach(tags, id: \.self) { tag in
                                TagView(tag: tag, showDelete: true) {
                                    tags.removeAll { $0 == tag }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Handle save
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

// MARK: - Edit Item View
struct EditItemView: View {
    let item: Item
    @Environment(\.dismiss) private var dismiss
    @State private var title: String
    @State private var description: String
    @State private var selectedCategory: String
    @State private var tags: [String]
    
    init(item: Item) {
        self.item = item
        self._title = State(initialValue: item.title)
        self._description = State(initialValue: item.description)
        self._selectedCategory = State(initialValue: item.category)
        self._tags = State(initialValue: item.tags)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Basic Information") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section("Category") {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(["Work", "Personal", "Important"], id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Tags") {
                    if !tags.isEmpty {
                        FlowLayout(spacing: 8) {
                            ForEach(tags, id: \.self) { tag in
                                TagView(tag: tag, showDelete: true) {
                                    tags.removeAll { $0 == tag }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Handle save
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Supporting Views
struct ItemRowView: View {
    let item: Item
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: item.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 50, height: 50)
            .clipped()
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    CategoryBadge(category: item.category)
                    
                    Spacer()
                    
                    Text(item.createdAt, style: .relative)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct SearchBarView: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search items...", text: $text)
            
            if !text.isEmpty {
                Button("Clear") {
                    text = ""
                }
                .font(.caption)
                .foregroundColor(.blue)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct CategoryChip: View {
    let category: MasterListView.ItemCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: category.icon)
                    .font(.caption)
                
                Text(category.rawValue)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(20)
        }
    }
}

struct CategoryBadge: View {
    let category: String
    
    var color: Color {
        switch category {
        case "Work": return .blue
        case "Personal": return .green
        case "Important": return .red
        default: return .gray
        }
    }
    
    var body: some View {
        Text(category)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.2))
            .foregroundColor(color)
            .cornerRadius(6)
    }
}

struct TagView: View {
    let tag: String
    var showDelete: Bool = false
    var onDelete: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 4) {
            Text(tag)
                .font(.caption)
            
            if showDelete {
                Button(action: { onDelete?() }) {
                    Image(systemName: "xmark")
                        .font(.caption2)
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.blue.opacity(0.2))
        .foregroundColor(.blue)
        .cornerRadius(6)
    }
}

struct FlowLayout: Layout {
    let spacing: CGFloat
    
    init(spacing: CGFloat = 8) {
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX,
                                    y: bounds.minY + result.frames[index].minY),
                         proposal: .unspecified)
        }
    }
}

struct FlowResult {
    let size: CGSize
    let frames: [CGRect]
    
    init(in maxWidth: CGFloat, subviews: LayoutSubviews, spacing: CGFloat) {
        var frames: [CGRect] = []
        var currentRowY: CGFloat = 0
        var currentRowWidth: CGFloat = 0
        var currentRowHeight: CGFloat = 0
        
        for subview in subviews {
            let subviewSize = subview.sizeThatFits(.unspecified)
            
            if currentRowWidth + subviewSize.width > maxWidth && !frames.isEmpty {
                currentRowY += currentRowHeight + spacing
                currentRowWidth = 0
                currentRowHeight = 0
            }
            
            frames.append(CGRect(origin: CGPoint(x: currentRowWidth, y: currentRowY), 
                               size: subviewSize))
            
            currentRowWidth += subviewSize.width + spacing
            currentRowHeight = max(currentRowHeight, subviewSize.height)
        }
        
        self.frames = frames
        self.size = CGSize(width: maxWidth, height: currentRowY + currentRowHeight)
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// MARK: - Data Models
struct Item: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let category: String
    let tags: [String]
    let imageURL: String
    let createdAt: Date
}

struct SampleData {
    static let items = [
        Item(title: "Project Planning", description: "Plan the upcoming project milestones and deliverables", category: "Work", tags: ["planning", "project"], imageURL: "https://picsum.photos/200/200?random=1", createdAt: Date().addingTimeInterval(-86400)),
        Item(title: "Grocery Shopping", description: "Buy ingredients for dinner this week", category: "Personal", tags: ["shopping", "food"], imageURL: "https://picsum.photos/200/200?random=2", createdAt: Date().addingTimeInterval(-43200)),
        Item(title: "Team Meeting", description: "Discuss quarterly goals and objectives", category: "Important", tags: ["meeting", "goals"], imageURL: "https://picsum.photos/200/200?random=3", createdAt: Date().addingTimeInterval(-21600)),
        Item(title: "Code Review", description: "Review pull requests from team members", category: "Work", tags: ["code", "review"], imageURL: "https://picsum.photos/200/200?random=4", createdAt: Date().addingTimeInterval(-7200)),
        Item(title: "Workout", description: "Evening workout session at the gym", category: "Personal", tags: ["fitness", "health"], imageURL: "https://picsum.photos/200/200?random=5", createdAt: Date().addingTimeInterval(-3600))
    ]
}

#Preview {
    NavigationAppTemplate()
}
