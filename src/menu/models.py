from django.db import models

class MenuSection(models.Model):
    title_txt = models.CharField(max_length=100)

    def __str__(self):
        return self.title_txt

class MenuItem(models.Model):
    # an admin-only identifier for the item
    name_txt = models.CharField(max_length=100)

    # the item's name on the website
    title_txt = models.CharField(max_length=100)

    # a description of the item
    desc_txt = models.CharField(max_length=200)

    # does the raw food disclaimer apply
    raw_disclaimer = models.BooleanField()

    # the section under which this item appears
    section = models.ForeignKey(MenuSection, on_delete=models.CASCADE)

    # an optional image of the menu item
    image = models.ImageField(upload_to='menu_images/', blank=True)

    def __str__(self):
        return self.name_txt
