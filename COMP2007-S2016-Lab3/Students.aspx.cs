﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

// using statements that are required to connect to EF DB
using COMP2007_S2016_Lab3.Models;
using System.Web.ModelBinding;

namespace COMP2007_S2016_Lab3
{
    public partial class Students : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // if loading the page for the first time, populate the student grid
            if (!IsPostBack)
            {
                // Get the student data
                this.GetStudents();
            }
        }

        /**
         * <summary>
         * This method gets the student data from the DB
         * </summary>
         * 
         * @method GetStudents
         * @returns {void}
         */
        protected void GetStudents()
        {
            // connect to EF
            using (DefaultConnection db = new DefaultConnection())
            {
                // query the Students Table using EF and LINQ
                var Students = (from allStudents in db.Students
                                select allStudents);

                // bind the result to the GridView
                StudentsGridView.DataSource = Students.ToList();
                StudentsGridView.DataBind();
            }
        }
        /**
         *  <summary>
         * This event handler deletes a student from the db using EF
         * </summary>
         *
         * @method StudentsGridView_RowDeleting
         * @param {object} sender 
         * @param {GridViewDeleteEventArgs} e
         * @retuens {void}
         * 
         */
        protected void StudentsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //store which row was clicked
            int selectedRow = e.RowIndex;

            //get the selected StudentID using the Grid's DataKey collection
            int StudentID = Convert.ToInt32(StudentsGridView.DataKeys[selectedRow].Values["StudentID"]);

            //use EF to find the selected student in the DB and remove it 
            using (DefaultConnection db = new DefaultConnection())
            {
                //create object of the Student Class and store the query string inside of it 
                Student deletedStudent = (from studentsRecords in db.Students
                                          where studentsRecords.StudentID == StudentID
                                          select studentsRecords).FirstOrDefault();
                //remove the selected student from the db
                db.Students.Remove(deletedStudent);

                //save my changes back to the db
                db.SaveChanges();

                //refresh the grid
                this.GetStudents();
            }
        }

        /**
         * <summary>
         * This event handler allows pagination to occur for the Students page 
         * <summary>
         * 
         * @method StudentsGridView_PageIndexChanging
         * @param {object} sender
         * @param {GridViewPageEventArgs} e
         * @returns {void}
         */
        protected void StudentsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //set the new page number
            StudentsGridView.PageIndex = e.NewPageIndex;

            //refresh the grid
            this.GetStudents();


        }
    }
}