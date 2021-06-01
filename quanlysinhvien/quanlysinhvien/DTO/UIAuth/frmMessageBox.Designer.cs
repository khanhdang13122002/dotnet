
namespace quanlysinhvien.DTO.UIAuth
{
    partial class frmMessageBox
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnSuccess = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnSuccess
            // 
            this.btnSuccess.BackColor = System.Drawing.Color.Transparent;
            this.btnSuccess.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnSuccess.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            this.btnSuccess.FlatAppearance.BorderSize = 2;
            this.btnSuccess.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Black;
            this.btnSuccess.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Black;
            this.btnSuccess.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSuccess.Font = new System.Drawing.Font("Segoe Print", 6F, System.Drawing.FontStyle.Bold);
            this.btnSuccess.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            this.btnSuccess.Location = new System.Drawing.Point(129, 92);
            this.btnSuccess.Name = "btnSuccess";
            this.btnSuccess.Size = new System.Drawing.Size(75, 23);
            this.btnSuccess.TabIndex = 0;
            this.btnSuccess.Text = "Ok";
            this.btnSuccess.UseVisualStyleBackColor = false;
            this.btnSuccess.Click += new System.EventHandler(this.btnSuccess_Click);
            // 
            // frmMessageBox
            // 
            this.AcceptButton = this.btnSuccess;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.Black;
            this.ClientSize = new System.Drawing.Size(328, 127);
            this.ControlBox = false;
            this.Controls.Add(this.btnSuccess);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmMessageBox";
            this.Opacity = 0.8D;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Login Success";
            this.Load += new System.EventHandler(this.frmMessageBox_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnSuccess;
    }
}