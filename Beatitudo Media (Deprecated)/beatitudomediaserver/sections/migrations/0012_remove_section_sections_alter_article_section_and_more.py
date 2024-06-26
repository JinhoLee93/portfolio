# Generated by Django 5.0.6 on 2024-05-14 06:49

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sections', '0011_sections_section_sections'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='section',
            name='sections',
        ),
        migrations.AlterField(
            model_name='article',
            name='section',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='articles', to='sections.section'),
        ),
        migrations.AlterField(
            model_name='article_auxiliary_data',
            name='article',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='article_auxiliary_data', to='sections.article'),
        ),
        migrations.AlterField(
            model_name='article_metadata',
            name='article',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='article_metadata', to='sections.article'),
        ),
        migrations.DeleteModel(
            name='Sections',
        ),
    ]
