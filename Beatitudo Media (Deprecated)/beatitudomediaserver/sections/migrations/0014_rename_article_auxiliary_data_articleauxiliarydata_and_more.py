# Generated by Django 5.0.6 on 2024-05-18 09:45

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('sections', '0013_remove_article_article_views_and_more'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Article_Auxiliary_Data',
            new_name='ArticleAuxiliaryData',
        ),
        migrations.RenameModel(
            old_name='Article_Metadata',
            new_name='ArticleMetadata',
        ),
    ]
