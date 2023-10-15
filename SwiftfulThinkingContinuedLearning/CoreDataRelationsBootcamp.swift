//
//  CoreDataRelationsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 12/10/2023.
//

import SwiftUI
import CoreData

class CoreDataManager{
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (descrition, error) in
            if let error = error{
                print("Error loading core data \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save(){
        do{
            try context.save()
            print("saved successfully!")
        }catch let error{
            print("Error saving core data \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipViewmodel: ObservableObject{
    
    let manager = CoreDataManager.instance
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init(){
        getBusiness()
        getDepartments()
        getEmployees()
    }
    
    func getBusiness(){
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        do{
            businesses = try manager.context.fetch(request)
        }catch let error{
            print("Erro fetching business \(error.localizedDescription)")
        }
    }
    
    func getEmployees(){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do{
            employees = try manager.context.fetch(request)
        }catch let error{
            print("Erro fetching business \(error.localizedDescription)")
        }
    }
    
    func getDepartments(){
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do{
            departments = try manager.context.fetch(request)
        }catch let error{
            print("Erro fetching business \(error.localizedDescription)")
        }
    }
    
    func addBusiness(){
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        save()
    }
    
    func addDepartment(){
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Marketing"
//        newDepartment.businesses = [businesses[0]]
        save()
    }
    
    func addEmployee(){
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Big Wiz"
        newEmployee.dateJoined = Date()
        newEmployee.age = 21
        
//        newEmployee.business = businesses[0]
//        newEmployee.department = departments[0]
        
        save()
    }
    
    func save(){
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.manager.save()
            self.getBusiness()
            self.getDepartments()
            self.getEmployees()
        }
    }
}

struct CoreDataRelationsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipViewmodel()
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing: 20) {
                    Button {
                        vm.addEmployee()
                    } label: {
                        Text("Perform action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true){
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true){
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true){
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct BusinessView: View{
    
    let entity: BusinessEntity
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "N/A")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity]{
                Text("Departments:")
                    .bold()
                
                ForEach(departments) { department in
                    Text(department.name ?? "N/A")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees:")
                    .bold()
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "N/A")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View{
    
    let entity: DepartmentEntity
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "N/A")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity]{
                Text("Departments:")
                    .bold()
                
                ForEach(businesses) { business in
                    Text(business.name ?? "N/A")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees:")
                    .bold()
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "N/A")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.cyan.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct EmployeeView: View{
    
    let entity: EmployeeEntity
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "N/A")")
                .bold()
            
            Text("Age: \(entity.age)")
            Text("Date Joined: \(entity.dateJoined ?? Date())")
            
            Text("Business: \(entity.business?.name ?? "N/A")")
                .bold()
            
            Text("Department: \(entity.department?.name ?? "N/A")")
                .bold()
            
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.orange.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct CoreDataRelationsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationsBootcamp()
    }
}

