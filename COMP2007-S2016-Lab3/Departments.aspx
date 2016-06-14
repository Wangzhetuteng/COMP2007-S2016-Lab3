<%@ Page Title="Departments" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Departments.aspx.cs" Inherits="COMP2007_S2016_Lab3.Departments" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-offset-2 col-md-8">
                <h1>Department List</h1>
                <a href="DepartmentDetails.aspx" class="btn btn-success btn-sm"><i class="fa fa-plus"></i> Add Department</a>
                
                <div>
                    <label for="PageSizeDropDownList">Record Per Page:</label>
                    <asp:DropDownList ID="PageSizeDropDownList" runat="server"
                        AutoPostBack="true" CssClass="btn btn-default btn-sm dropdown-toggle"
                        OnSelectedIndexChanged="PageSizeDropDownList_SelectedIndexChanged">
                        <asp:ListItem Text="3" Value="3"/>
                        <asp:ListItem Text="5" Value="5"/>
                        <asp:ListItem Text="10" Value="10"/>
                        <asp:ListItem Text="All" Value="10000"/>
                    </asp:DropDownList>
                </div>


                <asp:GridView runat="server" CssClass="table table-bordered table-striped table-hover" 
                    ID="DepartmentsGridView" AutoGenerateColumns="false" DataKeyNames="DepartmentID" 
                    OnRowDeleting="DepartmentsGridView_RowDeleting"
                    AllowPaging="true" PageSize="3" OnPageIndexChanging="DepartmentsGridView_PageIndexChanging"
                    AllowSorting="true" 
                    OnSorting="DepartmentsGridView_Sorting" OnRowDataBound="DepartmentsGridView_RowDataBound"
                    PagerStyle-CssClass="pagination-ys">
                    <Columns>
                        <asp:BoundField DataField="DepartmentID" HeaderText="Department ID" Visible="true" SortExpression="DepartmentID"/>
                        <asp:BoundField DataField="Name" HeaderText="Name" Visible="true" SortExpression="Name"/>
                        <asp:BoundField DataField="Budget" HeaderText="Budget" Visible="true" SortExpression="Budget"/>
                        
                        <asp:HyperLinkField HeaderText="Edit" Text="<i class= 'fa fa-pencil-square-o fa-lg'></i> Edit" 
                            NavigateUrl="~/DepartmentDetails.aspx.cs" ControlStyle-CssClass="btn btn-primary btn-sm" runat="server" 
                            DataNavigateUrlFields="DepartmentID" DataNavigateUrlFormatString="DepartmentDetails.aspx?DepartmentID={0}"/>
                        <asp:CommandField HeaderText="Delete" DeleteText="<i class='fa fa-trash-o fa-lg'></i> Delete"
                            ShowDeleteButton="true" ButtonType="Link" ControlStyle-CssClass="btn btn-danger btn-sm" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>




</asp:Content>
