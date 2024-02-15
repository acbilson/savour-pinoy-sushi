from django.db import models

class MenuSection(models.Model):

    # the section's name on the website
    display_txt = models.CharField(max_length=100)

    # a description or notes about the section
    desc_txt = models.CharField(max_length=200)

    # does the raw food disclaimer apply
    raw_disclaimer = models.BooleanField()

    def __str__(self):
        return self.display_txt

class MenuItem(models.Model):
    # the item's name on the website
    display_txt = models.CharField(max_length=100)

    # a description or notes about the item
    desc_txt = models.CharField(max_length=200, null=True)

    # the current price of the item
    price = models.DecimalField(max_digits=5, decimal_places=2)

    # does the raw food disclaimer apply
    raw_disclaimer = models.BooleanField(default=False)

    # the section under which this item appears
    section = models.ForeignKey(MenuSection, on_delete=models.CASCADE)

    # an optional image of the menu item
    image = models.ImageField(upload_to='menu_images/', null=True)

    def __str__(self):
        return self.display_txt
