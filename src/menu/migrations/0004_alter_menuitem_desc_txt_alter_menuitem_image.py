# Generated by Django 5.0.2 on 2024-02-15 21:45

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("menu", "0003_alter_menuitem_desc_txt_alter_menuitem_image_and_more"),
    ]

    operations = [
        migrations.AlterField(
            model_name="menuitem",
            name="desc_txt",
            field=models.CharField(max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name="menuitem",
            name="image",
            field=models.ImageField(null=True, upload_to="menu_images/"),
        ),
    ]
