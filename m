From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 25 Sep 2013 17:19:05 +0000
Subject: Re: [PATCH 1/3] media: i2c: Add ADV761X support
Message-Id: <52431B09.5080307@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/25/2013 08:31 PM, Guennadi Liakhovetski wrote:
> On Wed, 25 Sep 2013, Valentine wrote:
>
>> On 09/25/2013 06:08 PM, Guennadi Liakhovetski wrote:
>
> [snip]
>
>>>>> Using module parameters has a disadvantage, that all instances of this
>>>>> driver will get the same values, and it is quite possible to have
>>>>> several
>>>>> HDMI receivers in a system, I believe? Wouldn't it be better to pass
>>>>> these
>>>>> addresses from the platform data / DT?
>>>>
>>>> Yes, that doesn't look quite right, but I couldn't find a better solution
>>>> ATM.
>>>>
>>>> The problem is that this subdevice is going to be used by a soc_camera
>>>> driver,
>>>> and the soc_camera interface uses its own platform data for all I2C
>>>> subdevices.
>>>> Thus, if I pass the I2C addresses in client->dev.platform_data here (as in
>>>> adv7604), it's doing to be overwritten by the soc_camera_i2c_init()
>>>> function
>>>> with a soc_camera_subdev_desc data.
>>>>
>>>> Not sure what the correct solution should be. Any suggestions are greatly
>>>> appreciated.
>>>
>>> You don't think, that soc-camera makes it impossible to pass
>>> device-specific platform data to subdevices, right? For an example have a
>>> look e.g. at mt9v022 and arch/arm/mach-pxa/pcm990-baseboard.c or at
>>> mt9t111 and arch/arm/mach-shmobile/board-armadillo800eva.c.
>>
>> Yes, but in this case adv761x.c has to be a soc_camera i2c subdevice driver.
>> Which means it will get its platform data from ssdd->drv_priv like mt9v022 AOT
>> client->dev.platform_data, like adv7604 does.
>>
>> What if a non-soc_camera needs to use the adv7612 decoder?
>> IMHO, Looks like there's a conflict in the soc/non-soc camera driver subdevice
>> usage.
>
> I don't think, that just using soc-camera platform data struct will make
> it impossible for non-soc-camera bridge / video input drivers to use this
> subdevice driver.

This is the only problem I can see at the moment.
Do you see any other issues?

As I've said earlier the driver is based much on the adv7604 which is 
used for non-soc cameras.
I guess, implementing dv_timings and ISR for adv7612 will make it look 
even closer.
Other subdevice drivers (like 7180) seem to work with both soc/non-soc 
cameras.
Are you proposing to make it soc-cam-specific, move it to 
i2c/soc_camera/ and deal with a non-soc variant later if needed?

>In general several attempts have been made earlier to
> finally make soc-camera originated subdevice drivers
> soc-camera-independent. This hasn't been finalised due to a lack of a real
> life use-case. As soon as one appears, finalising that work shouldn't be
> too difficult.
>
>> For example, there's an adv7180 decoder on the Lager board, and its driver can
>> be successfully used with a soc_camera (rcar_vin) as well as
>> a PCI STA2X11 Video Input device. However, if the adv7180 needed a platform
>> data, there would be a conflict, since soc_camera uses
>> a different method of passing platform data to the subdevice driver.
>>
>> I don't think that making adv7612 subdevice "SOC"-specific would be the way to
>> go here since it may lead us to code duplication for non-soc video devices
>> later.
>>
>>>
>>>>>> +
>>>>>> +struct adv761x_color_format {
>>>>>> +	enum v4l2_mbus_pixelcode code;
>>>>>> +	enum v4l2_colorspace colorspace;
>>>>>> +};
>>>>>> +
>>>>>> +/* Supported color format list */
>>>>>> +static const struct adv761x_color_format adv761x_cfmts[] = {
>>>>>> +	{
>>>>>> +		.code		= V4L2_MBUS_FMT_RGB888_1X24,
>>>>>> +		.colorspace	= V4L2_COLORSPACE_SRGB,
>>>>>> +	},
>>>>>> +};
>>>>>> +
>>>>>> +/* ADV761X descriptor structure */
>>>>>> +struct adv761x_state {
>>>>>> +	struct v4l2_subdev			sd;
>>>>>> +	struct media_pad			pad;
>>>>>> +	struct v4l2_ctrl_handler		ctrl_hdl;
>>>>>> +
>>>>>> +	u8					edid[256];
>>>>>> +	unsigned				edid_blocks;
>>>>>> +	const struct adv761x_color_format	*cfmt;
>>>>>> +	u32					width;
>>>>>> +	u32					height;
>>>>>> +	enum v4l2_field				scanmode;
>>>>>> +
>>>>>> +	struct workqueue_struct			*work_queue;
>>>>>> +	struct delayed_work			enable_hotplug;
>>>>>> +
>>>>>> +	/* I2C clients */
>>>>>> +	struct i2c_client			*i2c_cec;
>>>>>> +	struct i2c_client			*i2c_infoframe;
>>>>>> +	struct i2c_client			*i2c_dpll;
>>>>>> +	struct i2c_client			*i2c_repeater;
>>>>>> +	struct i2c_client			*i2c_edid;
>>>>>> +	struct i2c_client			*i2c_hdmi;
>>>>>> +	struct i2c_client			*i2c_cp;
>>>>>> +};
>>>>>> +
>>>>>> +static inline struct v4l2_subdev *to_sd(struct v4l2_ctrl *ctrl)
>>>>>> +{
>>>>>> +	return &container_of(ctrl->handler, struct adv761x_state,
>>>>>> ctrl_hdl)->sd;
>>>>>> +}
>>>>>> +
>>>>>> +static inline struct adv761x_state *to_state(struct v4l2_subdev *sd)
>>>>>> +{
>>>>>> +	return container_of(sd, struct adv761x_state, sd);
>>>>>> +}
>>>>>> +
>>>>>> +/* I2C I/O operations */
>>>>>> +static s32 adv_smbus_read_byte_data(struct i2c_client *client, u8
>>>>>> command)
>>>>>> +{
>>>>>> +	s32 ret, i;
>>>>>> +
>>>>>> +	for (i = 0; i < 3; i++) {
>>>>>> +		ret = i2c_smbus_read_byte_data(client, command);
>>>>>
>>>>> Uhm, why do you need to do this 3 times?... I see adv7842 does that
>>>>> too...
>>>>> but e.g. adv7604 dies this only for writing and not for reading...
>>>>
>>>> Just thought it would be safe to retry in case of a failure.
>>>> Other drivers seem to retry I2C I/O as well. This is probably related to
>>>> the
>>>> possible cable issues. Not sure. Anyways, retrying doesn't seem to hurt,
>>>> does
>>>> it?
>>>
>>> It does, because it means there's something we don't understand. IMHO it
>>> should either work from the first time, or there should be an error, that
>>> we understand with a following error processing, that _might_ include
>>> re-trying. Re-trying just in case isn't good. Especially if no error has
>>> been observed.
>>
>> I have observed very rare errors when reading HDMI status. Just a couple of
>> times during this week. I'm not sure of the nature of those errors. Just
>> thought it would be OK to retry since other decoder drivers do so as well.
>
> Ok, understand. As I said, I personally don't like that, but, I think,
> Laurent will have a final word on this.
>

OK, thanks.

> [snip]
>
>>>>>> +/* Power management operations */
>>>>>> +#ifdef CONFIG_PM_SLEEP
>>>>>> +static int adv761x_suspend(struct device *dev)
>>>>>> +{
>>>>>> +	struct i2c_client *client = to_i2c_client(dev);
>>>>>> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
>>>>>> +
>>>>>> +	/* Power off */
>>>>>> +	return io_write(sd, 0x0c, 0x62);
>>>>>> +}
>>>>>> +
>>>>>> +static int adv761x_resume(struct device *dev)
>>>>>> +{
>>>>>> +	struct i2c_client *client = to_i2c_client(dev);
>>>>>> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
>>>>>> +
>>>>>> +	/* Initializes ADV761X to its default values */
>>>>>> +	return adv761x_core_init(sd);
>>>>>
>>>>> What if a system was suspended during capture? Is this enough to resume
>>>>> it
>>>>> automatically?
>>>>
>>>> Is it needed to auto-resume capture?
>>>> IIUC, adv7810 doesn't seem to do that in its resume callback.
>>>>
>>>> Since not many decoder drivers seem to implement PM, we probably could
>>>> drop it
>>>> altogether for now (in case capture auto-resume is needed).
>>>
>>> Yep, removing dummy PM is good, I think.
>>
>> OK, I can remove it.
>> I wouldn't call it dummy, though, since it does change the power state of the
>> chip.
>> The question of whether it needs to auto-resume the capture is still not clear
>> to me.
>
> I'm not 100% certain either, but at least what I am certain about, is that
> you need to restore the configuration before the suspend instead of just
> initialising to defaults. Or would the configuration be preserved. I mean
> in a sequence like
>
> set controls
> set EDID
> configure formats
> suspend
> resume
> start capture
>
> Would the controls, formats and EDID be preserved or lost?
>

OK, understood, thanks.
I guess PM could be dropped for now.

> In fact, looking a bit more at the driver, I've got a couple more
> questions.
>
> 1. Hotplug handling: you've got comments like "Pull down the hotplug pin,"
> but I don't see any code that would actually pull the pin? Am I missing it
> or is it permanently low?

It is supposed to be done by the camera driver that receives the hotplug 
notification.

>
> 2. You're using an own work queue just to queue a work to notify users
> about the event. Wouldn't it suffice to just use the scheduler work queue?

It probably would. I just didn't want to deviate much from the code that 
is already there (adv7604/adv7842/ad9389b/adv7511/cx25840).

>
>>>>>> diff --git a/include/media/adv761x.h b/include/media/adv761x.h
>>>>>> new file mode 100644
>>>>>> index 0000000..e6e6aea
>>>>>> --- /dev/null
>>>>>> +++ b/include/media/adv761x.h
>>>>>> @@ -0,0 +1,28 @@
>>>>>> +/*
>>>>>> + * adv761x Analog Devices ADV761X HDMI receiver driver
>>>>>> + *
>>>>>> + * Copyright (C) 2013 Cogent Embedded, Inc.
>>>>>> + * Copyright (C) 2013 Renesas Electronics Corporation
>>>>>> + *
>>>>>> + * This program is free software; you may redistribute it and/or
>>>>>> modify
>>>>>> + * it under the terms of the GNU General Public License as published
>>>>>> by
>>>>>> + * the Free Software Foundation; version 2 of the License.
>>>>>> + *
>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>>>>> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>>>> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>>>>> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>>>>>> HOLDERS
>>>>>> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>>>>>> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>>>>>> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>>>>>> + * SOFTWARE.
>>>>>> + *
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef _ADV761X_H_
>>>>>> +#define _ADV761X_H_
>>>>>> +
>>>>>> +/* notify events */
>>>>>> +#define ADV761X_HOTPLUG		1
>>>>>
>>>>> Is this header needed at all and - if so - does it have to be exported
>>>>> under include/ or would it be enough to put it under drivers/media/?
>>>>
>>>> Well, the ADV761X_HOTPLUG is supposed to be used by a camera driver for
>>>> hotplug notification events (as in adv7604). If we find a way to use
>>>> platform
>>>> data with soc_camera, it should go into this header as well.
>>>
>>> As well or instead? Do you really need to export ADV761X_HOTPLUG? And for
>>> platform data it's now preferable to use the include/linux/platform_data/
>>> directory, I think.
>>
>> As well.
>> This code is based on the ADV7604 driver. The define is for other drivers to
>> use (the ones that need to be notified of the EDID change, for example). As it
>> is not used with rcar_vin, I have no problem with dropping the EDID handling
>> altogether.
>
> Uhm, so, that code is untested? Then yes, personally, I'd rather drop it
> for now.

OK.
BTW, the EDID read/write code *is* tested. It is just not used for the 
soc_camera.
(It is impossible to use it for a soc_camera, as it doesn't support 
subdev user-space API)

>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>

Thanks,
Val.
