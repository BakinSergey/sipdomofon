# Generated by Django 2.2.5 on 2019-10-07 19:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0002_domofonuser_external_id'),
    ]

    operations = [
        migrations.AlterField(
            model_name='domofonuser',
            name='avatar',
            field=models.ImageField(default='./user/logo/default.png', max_length=127, upload_to='user\\logo', verbose_name='Фото профиля'),
        ),
    ]
