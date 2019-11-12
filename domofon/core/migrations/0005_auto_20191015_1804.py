# Generated by Django 2.2.5 on 2019-10-15 15:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0004_domofonuser_synapse_id'),
    ]

    operations = [
        migrations.AlterField(
            model_name='domofonuser',
            name='avatar',
            field=models.ImageField(default='./user/logo/default.png', max_length=127, upload_to='user/logo', verbose_name='Фото профиля'),
        ),
        migrations.AlterField(
            model_name='domofonuser',
            name='synapse_id',
            field=models.CharField(blank=True, max_length=80, null=True, unique=True),
        ),
    ]
