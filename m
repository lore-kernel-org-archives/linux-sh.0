From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 17 May 2013 20:53:44 +0000
Subject: Re: [PATCH v4] V4L2: soc_camera: Renesas R-Car VIN driver
Message-Id: <519698D8.7050107@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201305150256.36966.sergei.shtylyov@cogentembedded.com> <Pine.LNX.4.64.1305150742470.10596@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1305150742470.10596@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: mchehab@redhat.com, linux-media@vger.kernel.org, magnus.damm@gmail.com, linux-sh@vger.kernel.org, phil.edworthy@renesas.com, matsu@igel.co.jp, vladimir.barinov@cogentembedded.com

Hello.

On 05/15/2013 09:44 AM, Guennadi Liakhovetski wrote:

>
>> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>
>> Add Renesas R-Car VIN (Video In) V4L2 driver.
>>
>> Based on the patch by Phil Edworthy <phil.edworthy@renesas.com>.
>>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> [Sergei: removed deprecated IRQF_DISABLED flag, reordered/renamed 'enum chip_id'
>> values, reordered rcar_vin_id_table[] entries,  removed senseless parens from
>> to_buf_list() macro, used ALIGN() macro in rcar_vin_setup(), added {} to the
>> *if* statement  and  used 'bool' values instead of 0/1 where necessary, done
>> some reformatting and clarified some comments.]
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> This patch is against the 'media_tree.git' repo.
>>
>> Changes since version 3:
> Why aren't you using this:
>
> http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructure/63820
>
> ?
>
> Thanks
> Guennadi

     We have now incorporated the needed changes and I will post the 
updated patch.
I must note that you haven't managed to get rid of all CEU references in 
the shared
soc_scale_crop.c module, both in the variable names and in the comments.

WBR, Sergei

