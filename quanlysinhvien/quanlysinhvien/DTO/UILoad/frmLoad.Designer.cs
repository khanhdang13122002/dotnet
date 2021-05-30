
namespace quanlysinhvien.DTO.UILoad
{
    partial class frmLoad
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
            this.components = new System.ComponentModel.Container();
            this.cpbLoading = new CircularProgressBar.CircularProgressBar();
            this.tmerLoading = new System.Windows.Forms.Timer(this.components);
            this.SuspendLayout();
            // 
            // cpbLoading
            // 
            this.cpbLoading.AnimationFunction = WinFormAnimation.KnownAnimationFunctions.Liner;
            this.cpbLoading.AnimationSpeed = 500;
            this.cpbLoading.BackColor = System.Drawing.Color.Transparent;
            this.cpbLoading.Font = new System.Drawing.Font("Segoe Print", 6F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cpbLoading.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(85)))), ((int)(((byte)(213)))), ((int)(((byte)(219)))));
            this.cpbLoading.InnerColor = System.Drawing.Color.Transparent;
            this.cpbLoading.InnerMargin = 2;
            this.cpbLoading.InnerWidth = -1;
            this.cpbLoading.Location = new System.Drawing.Point(0, 0);
            this.cpbLoading.MarqueeAnimationSpeed = 2000;
            this.cpbLoading.Name = "cpbLoading";
            this.cpbLoading.OuterColor = System.Drawing.Color.FromArgb(((int)(((byte)(28)))), ((int)(((byte)(26)))), ((int)(((byte)(43)))));
            this.cpbLoading.OuterMargin = -25;
            this.cpbLoading.OuterWidth = 26;
            this.cpbLoading.ProgressColor = System.Drawing.Color.FromArgb(((int)(((byte)(85)))), ((int)(((byte)(213)))), ((int)(((byte)(219)))));
            this.cpbLoading.ProgressWidth = 2;
            this.cpbLoading.SecondaryFont = new System.Drawing.Font("Microsoft Sans Serif", 36F);
            this.cpbLoading.Size = new System.Drawing.Size(36, 36);
            this.cpbLoading.StartAngle = 270;
            this.cpbLoading.Style = System.Windows.Forms.ProgressBarStyle.Continuous;
            this.cpbLoading.SubscriptColor = System.Drawing.Color.FromArgb(((int)(((byte)(166)))), ((int)(((byte)(166)))), ((int)(((byte)(166)))));
            this.cpbLoading.SubscriptMargin = new System.Windows.Forms.Padding(10, -35, 0, 0);
            this.cpbLoading.SubscriptText = "";
            this.cpbLoading.SuperscriptColor = System.Drawing.Color.FromArgb(((int)(((byte)(166)))), ((int)(((byte)(166)))), ((int)(((byte)(166)))));
            this.cpbLoading.SuperscriptMargin = new System.Windows.Forms.Padding(10, 35, 0, 0);
            this.cpbLoading.SuperscriptText = "";
            this.cpbLoading.TabIndex = 0;
            this.cpbLoading.TextMargin = new System.Windows.Forms.Padding(1, 1, 0, 0);
            this.cpbLoading.UseWaitCursor = true;
            this.cpbLoading.Value = 100;
            // 
            // tmerLoading
            // 
            this.tmerLoading.Enabled = true;
            this.tmerLoading.Tick += new System.EventHandler(this.tmerLoading_Tick);
            // 
            // frmLoad
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.Black;
            this.ClientSize = new System.Drawing.Size(104, 64);
            this.Controls.Add(this.cpbLoading);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "frmLoad";
            this.Opacity = 0.9D;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmLogin";
            this.Load += new System.EventHandler(this.frmLogin_Load);
            this.ResumeLayout(false);

        }

        #endregion

        public CircularProgressBar.CircularProgressBar cpbLoading;
        public System.Windows.Forms.Timer tmerLoading;
    }
}