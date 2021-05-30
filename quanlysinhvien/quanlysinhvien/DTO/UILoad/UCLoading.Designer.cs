
namespace quanlysinhvien.DTO.UILoad
{
    partial class UCLoading
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.cpgLoading = new CircularProgressBar.CircularProgressBar();
            this.tmerLoading = new System.Windows.Forms.Timer(this.components);
            this.SuspendLayout();
            // 
            // cpgLoading
            // 
            this.cpgLoading.AnimationFunction = WinFormAnimation.KnownAnimationFunctions.CircularEaseOut;
            this.cpgLoading.AnimationSpeed = 1;
            this.cpgLoading.BackColor = System.Drawing.Color.Transparent;
            this.cpgLoading.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            this.cpgLoading.Dock = System.Windows.Forms.DockStyle.Fill;
            this.cpgLoading.Font = new System.Drawing.Font("Microsoft Sans Serif", 5.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.cpgLoading.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(85)))), ((int)(((byte)(213)))), ((int)(((byte)(219)))));
            this.cpgLoading.InnerColor = System.Drawing.Color.Transparent;
            this.cpgLoading.InnerMargin = 2;
            this.cpgLoading.InnerWidth = -1;
            this.cpgLoading.Location = new System.Drawing.Point(0, 0);
            this.cpgLoading.MarqueeAnimationSpeed = 2000;
            this.cpgLoading.Name = "cpgLoading";
            this.cpgLoading.OuterColor = System.Drawing.Color.FromArgb(((int)(((byte)(28)))), ((int)(((byte)(26)))), ((int)(((byte)(43)))));
            this.cpgLoading.OuterMargin = -25;
            this.cpgLoading.OuterWidth = 26;
            this.cpgLoading.ProgressColor = System.Drawing.Color.FromArgb(((int)(((byte)(85)))), ((int)(((byte)(213)))), ((int)(((byte)(219)))));
            this.cpgLoading.ProgressWidth = 2;
            this.cpgLoading.SecondaryFont = new System.Drawing.Font("Microsoft Sans Serif", 36F);
            this.cpgLoading.Size = new System.Drawing.Size(36, 36);
            this.cpgLoading.StartAngle = 270;
            this.cpgLoading.Style = System.Windows.Forms.ProgressBarStyle.Continuous;
            this.cpgLoading.SubscriptColor = System.Drawing.Color.FromArgb(((int)(((byte)(166)))), ((int)(((byte)(166)))), ((int)(((byte)(166)))));
            this.cpgLoading.SubscriptMargin = new System.Windows.Forms.Padding(10, -35, 0, 0);
            this.cpgLoading.SubscriptText = "";
            this.cpgLoading.SuperscriptColor = System.Drawing.Color.FromArgb(((int)(((byte)(166)))), ((int)(((byte)(166)))), ((int)(((byte)(166)))));
            this.cpgLoading.SuperscriptMargin = new System.Windows.Forms.Padding(10, 35, 0, 0);
            this.cpgLoading.SuperscriptText = "";
            this.cpgLoading.TabIndex = 0;
            this.cpgLoading.Text = "1%";
            this.cpgLoading.TextMargin = new System.Windows.Forms.Padding(1, 1, 0, 0);
            this.cpgLoading.Value = 100;
            // 
            // tmerLoading
            // 
            this.tmerLoading.Enabled = true;
            this.tmerLoading.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // UCLoading
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.cpgLoading);
            this.Name = "UCLoading";
            this.Size = new System.Drawing.Size(36, 36);
            this.ResumeLayout(false);

        }

        #endregion
        public System.Windows.Forms.Timer tmerLoading;
        public CircularProgressBar.CircularProgressBar cpgLoading;
    }
}
