# Generated by Django 5.0.6 on 2024-05-13 04:26

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('sections', '0009_alter_article_section_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='section',
            name='sections',
        ),
        migrations.DeleteModel(
            name='Sections',
        ),
    ]
