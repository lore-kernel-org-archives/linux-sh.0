From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Wed, 02 Dec 2015 07:23:36 +0000
Subject: Re: Rcar Gen2: DU: Bootlogs Error and show image error
Message-Id: <565E9C78.4080203@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <564ECE30.9000206@jinso.co.jp>
In-Reply-To: <564ECE30.9000206@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Laurent-san

Sorry to bother you again!

On 2015年11月27日 15:13, Cao Minh Hiep wrote:
> Hello Laurent-san,
>
>
>>>>> But as you know, we have reported to you before, have some problems
>>>>> related to DU driver.
>>>>> We couldn't show a image on the display. We found the messages as 
>>>>> showed
>>>>> below:
>>>>> -----
>>>>> Boot logs on Rcar-H2:
>>>>> rcar-du feb00000.display: failed to initialize encoder
>>>>> /i2c@e6520000/hdmi@39 (-38), skipping
>>>>> rcar-du feb00000.display: fb0:  frame buffer device
>>>>> -----
>>>>> Boot logs on Rcar-M2:
>>>>> rcar-du feb00000.display: failed to initialize encoder
>>>>> /i2c@e6530000/hdmi@39 (-g
>>>>> rcar-du feb00000.display: error: no encoder could be initialized
>>>>> rcar-du feb00000.display: failed to initialize DRM/KMS (-22)
>>>>> rcar-du: probe of feb00000.display failed with error -22
>>>>> -----
>>>>>
>>>>> This is tested on linux stable v4.3.
>>>>> Please have a look when you have time.
>>>> Have you enabled CONFIG_DRM_RCAR_HDMI ?
>>> Yes, These initialize logs are taken with default config that
>>> CONFIG_DRM_RCAR_HDMI disabled at v4.3.
>>> But when we enabled CONFIG_DRM_RCAR_HDMI, then we still could not show
>>> any images on HDMI or RGB Screen.
>>>
>>> I found that, CONFIG_DRM_RCAR_HDMI have already enabled in default
>>> config at v4.4-rc2.
>>> But have a error message as below and DU is still not improved(still 
>>> can
>>> not show images on screen).
>>>
>>>
>>> On Rcar-H2(Lager):
>>>
>>> [drm] Initialized drm 1.1.0 20060810
>>> [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>>> [drm] No driver support for vblank timestamp query.
>>> rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
>>> rcar-du feb00000.display: fb0:  frame buffer device
>>> [drm] Initialized rcar-du 1.0.0 20130110 on minor 0
>>>
>>> On Rcar-M2(Koelsch):
>>>
>>> [drm] Initialized drm 1.1.0 20060810
>>> [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>>> [drm] No driver support for vblank timestamp query.
>>> rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
>>> rcar-du feb00000.display: fb0:  frame buffer device
>>> [drm] Initialized rcar-du 1.0.0 20130110 on minor 0
>> -517 (-EPROBE_DEFER) means that probe deferral is requested because a 
>> required
>> dependency is not present. Have you compiled and loaded the adv7511 
>> driver
>> (CONFIG_DRM_I2C_ADV7511) ?
>>
> Yes, CONFIG_DRM_I2C_ADV7511=y has already enabled in default config at 
> v4.4-rc2.
> I also have enabled CONFIG_DRM_SHMOBILE and CONFIG_FB_SH_MOBILE_HDMI 
> then test.
> But It has nothing change.
> Is there other configuration or reason could we think?
>

Does this problem happen on your board?
If not, Could you please send me your config file?.


Thank you!
Jinso/Hiep

