From: Luca Santini <luca.santini@spesonline.com>
Date: Thu, 31 Jul 2008 14:27:56 +0000
Subject: i2c old to new style conversion
Message-Id: <4891CBEC.9090803@spesonline.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000701090005090601000600"
List-Id: <linux-sh.vger.kernel.org>
References: <4891CB91.6040308@spesonline.com>
In-Reply-To: <4891CB91.6040308@spesonline.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------000701090005090601000600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

(diff attached)


Hi Manuel,
i'm trying the conversion of wm8731 driver and a attach my patch.

The problem is: the method wm8731_i2c_probe() - connected to
i2c_add_driver.probe field - isn't called and alsa says "No Soundcard
found".


in the old style driver the method wm8731_codec_probe()  - connected to
i2c_add_driver.attach_adapter field -  is called during initialization
by i2c_add_driver() .

How to call wm8731_i2c_probe()? Do i miss something?



--------------000701090005090601000600
Content-Type: text/x-diff;
 name="wm8731.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wm8731.patch"


605,609c607,617
< static struct i2c_driver wm8731_i2c_driver;
< static struct i2c_client client_template;
< 
< /* If the i2c layer weren't so broken, we could pass this kind of data
<    around */
---
> static void wm8731_deinit(struct snd_soc_device *socdev)
> {
> 	if (socdev) {
> 		wm8731_dapm_event(socdev->codec, SNDRV_CTL_POWER_D3cold);
> 		snd_soc_free_pcms(socdev);
> 		snd_soc_dapm_free(socdev);
> 		kfree(socdev->codec->private_data);
> 		kfree(socdev->codec->reg_cache);
> 		kfree(socdev->codec);
> 	}
> }
611c619
< static int wm8731_codec_probe(struct i2c_adapter *adap, int addr, int kind)
---
> static int wm8731_i2c_probe(struct i2c_client *client, const struct i2c_device_id * id /*SPES*/)
614d621
< 	struct wm8731_setup_data *setup = socdev->codec_data;
616d622
< 	struct i2c_client *i2c;
619,620c625
< 	if (addr != setup->i2c_address)
< 		return -ENODEV;
---
622,637d626
< 	client_template.adapter = adap;
< 	client_template.addr = addr;
< 
< 	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
< 	if (i2c == NULL) {
< 		kfree(codec);
< 		return -ENOMEM;
< 	}
< 	i2c_set_clientdata(i2c, codec);
< 	codec->control_data = i2c;
< 
< 	ret = i2c_attach_client(i2c);
< 	if (ret < 0) {
< 		err("failed to attach codec at addr %x\n", addr);
< 		goto err;
< 	}
638a628,630
> 	i2c_set_clientdata(client,socdev);
> 	codec->control_data = client;	
> 	
640,641c632,633
< 	if (ret < 0) {
< 		err("failed to initialise WM8731\n");
---
> 	if (unlikely(ret < 0)) {
> 		err("failed to initialise WM8731 codec\n");
648d639
< 	kfree(i2c);
652c643
< static int wm8731_i2c_detach(struct i2c_client *client)
---
> static int wm8731_i2c_remove(struct i2c_client *client)
654,659c645
< 	struct snd_soc_codec *codec = i2c_get_clientdata(client);
< 	i2c_detach_client(client);
< 	kfree(codec->reg_cache);
< 	kfree(client);
< 	return 0;
< }
---
> 	struct snd_soc_device *socdev = i2c_get_clientdata(client);
661,663c647,649
< static int wm8731_i2c_attach(struct i2c_adapter *adap)
< {
< 	return i2c_probe(adap, &addr_data, wm8731_codec_probe);
---
> 	wm8731_deinit(socdev);
> 
> 	return 0;
666d651
< /* corgi i2c codec control layer */
672,676d656
< 	.id =             I2C_DRIVERID_WM8731,
< 	.attach_adapter = wm8731_i2c_attach,
< 	.detach_client =  wm8731_i2c_detach,
< 	.command =        NULL,
< };
678,680c658,660
< static struct i2c_client client_template = {
< 	.name =   "WM8731",
< 	.driver = &wm8731_i2c_driver,
---
> 	.probe	= wm8731_i2c_probe,
> 	.remove	= wm8731_i2c_remove,
> 
729,733d716
< 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
< 	struct snd_soc_codec *codec = socdev->codec;
< 
< 	if (codec->control_data)
< 		wm8731_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
735,736d717
< 	snd_soc_free_pcms(socdev);
< 	snd_soc_dapm_free(socdev);
740,741d720
< 	kfree(codec->private_data);
< 	kfree(codec);

--------------000701090005090601000600--
