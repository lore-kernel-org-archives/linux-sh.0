From: Takanari Hayama <taki@igel.co.jp>
Date: Thu, 27 Nov 2014 00:57:30 +0000
Subject: Re: [PATCH 1/2] v4l: vsp1: Reset VSP1 RPF source address
Message-Id: <547676FA.6090406@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1416982792-11917-1-git-send-email-taki@igel.co.jp>	<1416982792-11917-2-git-send-email-taki@igel.co.jp> <CAMuHMdWFgaxgNFOkXktBzoVe7ncjD0Xu12YHV1BFrZUh11UzDQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWFgaxgNFOkXktBzoVe7ncjD0Xu12YHV1BFrZUh11UzDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Geert,

On 11/26/14, 5:59 PM, Geert Uytterhoeven wrote:
> Hi Hayama-san,
> 
> On Wed, Nov 26, 2014 at 7:19 AM, Takanari Hayama <taki@igel.co.jp> wrote:
>> @@ -179,6 +190,10 @@ static void rpf_vdev_queue(struct vsp1_video *video,
>>                            struct vsp1_video_buffer *buf)
>>  {
>>         struct vsp1_rwpf *rpf = container_of(video, struct vsp1_rwpf, video);
>> +       int i;
>> +
>> +       for (i = 0; i < 3; i++)
>> +               rpf->buf_addr[i] = buf->addr[i];
> 
> vsp1_video_buffer.addr is "dma_addr_t addr[3];"...

Oops. Thank you for pointing that out.

> BTW, you can use memcpy() instead of an explicit loop.

I thought about it too. However, it might not be that straight forward.

VSP1 accepts only 32-bit address. If we enable LPAE, the address should
be converted and mapped to 32-bit address space via IPMMU. So, once
IPMMU is supported, we should do address mapping.

So, I guess we should leave this loop as is here, so that we can add
some address conversion in the future.

>>
>>         vsp1_rpf_write(rpf, VI6_RPF_SRCM_ADDR_Y,
>>                        buf->addr[0] + rpf->offsets[0]);
>> diff --git a/drivers/media/platform/vsp1/vsp1_rwpf.h b/drivers/media/platform/vsp1/vsp1_rwpf.h
>> index 28dd9e7..1f98fe3 100644
>> --- a/drivers/media/platform/vsp1/vsp1_rwpf.h
>> +++ b/drivers/media/platform/vsp1/vsp1_rwpf.h
>> @@ -39,6 +39,8 @@ struct vsp1_rwpf {
>>         struct v4l2_rect crop;
>>
>>         unsigned int offsets[2];
>> +
>> +       unsigned int buf_addr[3];
> 
> ... hence the above should use dma_addr_t, too.
> 
> If CONFIG_ARM_LPAE is enabled, CONFIG_ARCH_DMA_ADDR_T_64BIT
> will be enabled, too, and dma_addr_t will be u64.

Thanks. Although we cannot support LPAE for VSP1 without IPMMU, I'll
change it to dma_addr_t anyway.

> 
>>  };

Cheers,
Takanari Hayama, Ph.D. (taki@igel.co.jp)
IGEL Co.,Ltd.
http://www.igel.co.jp/
