# Generated by Django 5.0.6 on 2024-05-11 13:59

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Article',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.TextField()),
                ('article_views', models.IntegerField()),
                ('thumbnail_url', models.TextField()),
                ('article_url', models.TextField()),
                ('article_metadata_url', models.TextField()),
                ('article_auxiliary_data_url', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='Article_Auxiliary_Data',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('loved', models.BooleanField()),
                ('count_of_loved', models.IntegerField()),
                ('count_of_shared', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Article_Metadata',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('time_to_read', models.IntegerField()),
                ('date', models.TextField()),
            ],
        ),
    ]
