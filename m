From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 02 Sep 2013 15:09:11 +0000
Subject: Re: [RFC 01/10] drm: ADV7511 i2c HDMI encoder driver
Message-Id: <5224AA17.6060806@metafoo.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1377866264-21110-2-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1377866264-21110-2-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/02/2013 05:01 PM, Laurent Pinchart wrote:
> Hi Lars-Peter,
> 
> On Monday 02 September 2013 16:43:25 Lars-Peter Clausen wrote:
>> On 09/02/2013 04:15 PM, Laurent Pinchart wrote:
>>> On Monday 02 September 2013 15:40:22 Lars-Peter Clausen wrote:
>>>> On 09/02/2013 03:18 PM, Laurent Pinchart wrote:
>>>>> On Friday 30 August 2013 14:37:35 Ulrich Hecht wrote:
>>>>>> ADV7511 driver snapshot taken from commit f416e32 of xcomm_zynq_3_10
>>>>>> branch at https://github.com/analogdevicesinc/linux.git
>>>>>
>>>>> I believe Lars-Peter (CC'ed) was planning to upstream the driver.
>>>>> Lars-Peter, could you please share your plans ?
>>>>
>>>> My plan was to have all this upstream long time ago ;)
>>>>
>>>> As I said in that other thread, I don't think it is a good idea to have
>>>> two drivers for the same device. But if nobody else sees a problem with
>>>> this and as long as the v4l driver doesn't have devicetree support I
>>>> guess we could get away with it for now. Even if it will probably haunt
>>>> us later on.
>>>>
>>>> There are still a few minor bits and pieces to iron out, but lets try to
>>>> aim for 2.6.13.
>>>
>>> If you can make it for 2.6.13 I will be extremely impressed :-)
>>
>> Yea, I know DRM always takes a bit longer...
> 
> I think you meant 3.13 ;-)
> 
>>> Do you plan to push the driver yourself ? If so, I would appreciate if you
>>> could CC me. If there's just a few minor bits to iron out I can already
>>> review your latest version if that can help.
>>
>> There are a couple of style issues, so if you review the driver ignore these
>> for now, but otherwise feedback is welcome, thanks. And I'm not also quite
>> happy with the ASoC integration yet.
> 
> Sure. Is the version available from the above branch the latest version ?

Yes, you can find it here:
https://github.com/analogdevicesinc/linux/tree/xcomm_zynq/drivers/gpu/drm/i2c

Oh and the DT bindings also still need proper documentation.

- Lars
