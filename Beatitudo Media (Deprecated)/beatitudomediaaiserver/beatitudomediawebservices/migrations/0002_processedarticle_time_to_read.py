# Generated by Django 5.0.6 on 2024-06-05 09:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('beatitudomediawebservices', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='processedarticle',
            name='time_to_read',
            field=models.IntegerField(default=0),
        ),
    ]
