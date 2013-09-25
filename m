From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 25 Sep 2013 20:36:00 +0000
Subject: Re: [PATCH 1/3] media: i2c: Add ADV761X support
Message-Id: <52434930.2050305@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/25/2013 10:33 PM, Guennadi Liakhovetski wrote:
> Hi Valentine,
>
> On Wed, 25 Sep 2013, Valentine wrote:
>
>> On 09/25/2013 08:31 PM, Guennadi Liakhovetski wrote:
>>> On Wed, 25 Sep 2013, Valentine wrote:
>>>
>>>> On 09/25/2013 06:08 PM, Guennadi Liakhovetski wrote:
>>>
>>> [snip]
>>>
>>>>>>> Using module parameters has a disadvantage, that all instances of
>>>>>>> this
>>>>>>> driver will get the same values, and it is quite possible to have
>>>>>>> several
>>>>>>> HDMI receivers in a system, I believe? Wouldn't it be better to pass
>>>>>>> these
>>>>>>> addresses from the platform data / DT?
>>>>>>
>>>>>> Yes, that doesn't look quite right, but I couldn't find a better
>>>>>> solution
>>>>>> ATM.
>>>>>>
>>>>>> The problem is that this subdevice is going to be used by a soc_camera
>>>>>> driver,
>>>>>> and the soc_camera interface uses its own platform data for all I2C
>>>>>> subdevices.
>>>>>> Thus, if I pass the I2C addresses in client->dev.platform_data here
>>>>>> (as in
>>>>>> adv7604), it's doing to be overwritten by the soc_camera_i2c_init()
>>>>>> function
>>>>>> with a soc_camera_subdev_desc data.
>>>>>>
>>>>>> Not sure what the correct solution should be. Any suggestions are
>>>>>> greatly
>>>>>> appreciated.
>>>>>
>>>>> You don't think, that soc-camera makes it impossible to pass
>>>>> device-specific platform data to subdevices, right? For an example have
>>>>> a
>>>>> look e.g. at mt9v022 and arch/arm/mach-pxa/pcm990-baseboard.c or at
>>>>> mt9t111 and arch/arm/mach-shmobile/board-armadillo800eva.c.
>>>>
>>>> Yes, but in this case adv761x.c has to be a soc_camera i2c subdevice
>>>> driver.
>>>> Which means it will get its platform data from ssdd->drv_priv like mt9v022
>>>> AOT
>>>> client->dev.platform_data, like adv7604 does.
>>>>
>>>> What if a non-soc_camera needs to use the adv7612 decoder?
>>>> IMHO, Looks like there's a conflict in the soc/non-soc camera driver
>>>> subdevice
>>>> usage.
>>>
>>> I don't think, that just using soc-camera platform data struct will make
>>> it impossible for non-soc-camera bridge / video input drivers to use this
>>> subdevice driver.
>>
>> This is the only problem I can see at the moment.
>> Do you see any other issues?
>>
>> As I've said earlier the driver is based much on the adv7604 which is used for
>> non-soc cameras.
>> I guess, implementing dv_timings and ISR for adv7612 will make it look even
>> closer.
>> Other subdevice drivers (like 7180) seem to work with both soc/non-soc
>> cameras.
>> Are you proposing to make it soc-cam-specific, move it to i2c/soc_camera/ and
>> deal with a non-soc variant later if needed?
>
> I wouldn't call it soc-camera specific. It would just include an
> soc-camera header and use one soc-camera struct. It wouldn't even require
> loading the soc-camera core module, let alone using soc-camera driver
> binding schemes. So, it would be a very mild dependency. As for where you
> put it - I don't care that much either.

OK, thanks.

>
>>> In fact, looking a bit more at the driver, I've got a couple more
>>> questions.
>>>
>>> 1. Hotplug handling: you've got comments like "Pull down the hotplug pin,"
>>> but I don't see any code that would actually pull the pin? Am I missing it
>>> or is it permanently low?
>>
>> It is supposed to be done by the camera driver that receives the hotplug
>> notification.
>
> Hm, seems strange to me - that pin belongs to the HDMI interface AFAICS
> and the camera host / bridge driver knows nothing about HDMI... E.g.
> adv7842_delayed_work_enable_hotplug(), IIUC, does enable the hotplug
> detection pin itself. The adv7604 handling looks suspicious to me...
>
> BTW, the free ADV7612 "datasheet" with no register information and just a
> general description does mention hotplug control pins, so, I really think
> it should be a task of the HDMI decoder driver to control those.

IIUC, these pins are supposed to be controlled by the camera or SOC-GPIO.

>
>>> 2. You're using an own work queue just to queue a work to notify users
>>> about the event. Wouldn't it suffice to just use the scheduler work queue?
>>
>> It probably would. I just didn't want to deviate much from the code that is
>> already there (adv7604/adv7842/ad9389b/adv7511/cx25840).
>>
>>>
>>>>>>>> diff --git a/include/media/adv761x.h b/include/media/adv761x.h
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..e6e6aea
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/include/media/adv761x.h
>>>>>>>> @@ -0,0 +1,28 @@
>>>>>>>> +/*
>>>>>>>> + * adv761x Analog Devices ADV761X HDMI receiver driver
>>>>>>>> + *
>>>>>>>> + * Copyright (C) 2013 Cogent Embedded, Inc.
>>>>>>>> + * Copyright (C) 2013 Renesas Electronics Corporation
>>>>>>>> + *
>>>>>>>> + * This program is free software; you may redistribute it and/or
>>>>>>>> modify
>>>>>>>> + * it under the terms of the GNU General Public License as
>>>>>>>> published
>>>>>>>> by
>>>>>>>> + * the Free Software Foundation; version 2 of the License.
>>>>>>>> + *
>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>>>>>>>> KIND,
>>>>>>>> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
>>>>>>>> WARRANTIES OF
>>>>>>>> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>>>>>>> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>>>>>>>> HOLDERS
>>>>>>>> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
>>>>>>>> IN AN
>>>>>>>> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
>>>>>>>> IN
>>>>>>>> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>>>>>>> THE
>>>>>>>> + * SOFTWARE.
>>>>>>>> + *
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#ifndef _ADV761X_H_
>>>>>>>> +#define _ADV761X_H_
>>>>>>>> +
>>>>>>>> +/* notify events */
>>>>>>>> +#define ADV761X_HOTPLUG		1
>>>>>>>
>>>>>>> Is this header needed at all and - if so - does it have to be
>>>>>>> exported
>>>>>>> under include/ or would it be enough to put it under drivers/media/?
>>>>>>
>>>>>> Well, the ADV761X_HOTPLUG is supposed to be used by a camera driver
>>>>>> for
>>>>>> hotplug notification events (as in adv7604). If we find a way to use
>>>>>> platform
>>>>>> data with soc_camera, it should go into this header as well.
>>>>>
>>>>> As well or instead? Do you really need to export ADV761X_HOTPLUG? And
>>>>> for
>>>>> platform data it's now preferable to use the
>>>>> include/linux/platform_data/
>>>>> directory, I think.
>>>>
>>>> As well.
>>>> This code is based on the ADV7604 driver. The define is for other drivers
>>>> to
>>>> use (the ones that need to be notified of the EDID change, for example).
>>>> As it
>>>> is not used with rcar_vin, I have no problem with dropping the EDID
>>>> handling
>>>> altogether.
>>>
>>> Uhm, so, that code is untested? Then yes, personally, I'd rather drop it
>>> for now.
>>
>> OK.
>> BTW, the EDID read/write code *is* tested. It is just not used for the
>> soc_camera.
>> (It is impossible to use it for a soc_camera, as it doesn't support subdev
>> user-space API)
>
> Ok, if it's been tested, it's good to keep it.

OK, thanks.

>
>>
>>>
>>> Thanks
>>> Guennadi
>>> ---
>>> Guennadi Liakhovetski, Ph.D.
>>> Freelance Open-Source Software Developer
>>> http://www.open-technology.de/
>>>

Thanks,
Val.

