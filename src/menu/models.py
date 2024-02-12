from django.db import models

class MenuSection(models.Model):
    title_txt = models.CharField(max_length=100)

    def __str__(self):
        return self.title_txt

class MenuItem(models.Model):
    title_txt = models.CharField(max_length=100)
    desc_txt = models.CharField(max_length=200)
    heat_rating = models.IntegerField(default=0)
    section = models.ForeignKey(MenuSection, on_delete=models.CASCADE)

    def __str__(self):
        return self.title_txt
