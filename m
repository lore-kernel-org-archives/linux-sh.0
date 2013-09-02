From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 02 Sep 2013 13:40:22 +0000
Subject: Re: [RFC 01/10] drm: ADV7511 i2c HDMI encoder driver
Message-Id: <52249546.5000705@metafoo.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1377866264-21110-2-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1377866264-21110-2-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/02/2013 03:18 PM, Laurent Pinchart wrote:
> Hi Ulrich,
> 
> Thank you for the patch.
> 
> On Friday 30 August 2013 14:37:35 Ulrich Hecht wrote:
>> ADV7511 driver snapshot taken from commit f416e32 of xcomm_zynq_3_10 branch
>> at https://github.com/analogdevicesinc/linux.git
> 
> I believe Lars-Peter (CC'ed) was planning to upstream the driver. Lars-Peter, 
> could you please share your plans ?

My plan was to have all this upstream long time ago ;)

As I said in that other thread, I don't think it is a good idea to have two
drivers for the same device. But if nobody else sees a problem with this and
as long as the v4l driver doesn't have devicetree support I guess we could
get away with it for now. Even if it will probably haunt us later on.

There are still a few minor bits and pieces to iron out, but lets try to aim
for 2.6.13.

- Lars

> 
>> Changed to export its i2c_client handle via platform_data, which is the only
>> way I could come up with to use a DRM encoder that is not attached to a
>> dedicated on-GPU i2c bus.
>>
>> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
>> ---
>>  drivers/gpu/drm/Kconfig             |   6 +
>>  drivers/gpu/drm/i2c/Makefile        |   3 +
>>  drivers/gpu/drm/i2c/adv7511.h       | 455 +++++++++++++++++
>>  drivers/gpu/drm/i2c/adv7511_audio.c | 304 +++++++++++
>>  drivers/gpu/drm/i2c/adv7511_core.c  | 981 +++++++++++++++++++++++++++++++++
>>  5 files changed, 1749 insertions(+)
>>  create mode 100644 drivers/gpu/drm/i2c/adv7511.h
>>  create mode 100644 drivers/gpu/drm/i2c/adv7511_audio.c
>>  create mode 100644 drivers/gpu/drm/i2c/adv7511_core.c
> 

