# Generated by Django 5.0.6 on 2024-05-12 09:17

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sections', '0007_remove_article_auxiliary_data_loved_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='article_metadata',
            name='article',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='sections.article'),
        ),
    ]