apt-get update
apt-get install --no-install-recommends -y apache2 php php-mysql
service apache2 restart

gsutil cp gs://cloud-training/gcpfci/my-excellent-blog.png my-excellent-blog.png
echo "<html>
    <head>
        <title>Welcome to my webpage</title>
    </head>
    <body>
        <img src='IMGSRC'>
        <h1>Welcome to my webpage in cloudsqlip CLOUDSQLIP - DBUSER:DBPASSWORD</h1>
        <?php
        \$dbserver = \"CLOUDSQLIP\";
        \$dbuser = \"DBUSER\";
        \$dbpassword = \"DBPASSWORD\";
        \$conn = new mysqli(\$dbserver, \$dbuser, \$dbpassword);
        if (mysqli_connect_errno()) {
            echo ('Database connection failed: ' . mysqli_connect_error());
        }
        else {
            echo ('Database connection succeeded.');
        }
        ?>
    </body>
</html>" > /var/www/html/index.php

service apache2 restart
# sed -i "s/IMGSRC/${var.img_src}/" /var/www/html/index.php
# sed -i "s/CLOUDSQLIP/${var.sql_ip}/" /var/www/html/index.php
# sed -i "s/DBUSER/${var.db_user}/" /var/www/html/index.php
# sed -i "s/DBPASSWORD/${var.db_password}/" /var/www/html/index.php
# http://storage.googleapis.com/cloud-training/gcpfci/my-excellent-blog.png