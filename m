From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 26 Jun 2013 07:28:30 +0000
Subject: Re: [PATCH v7] V4L2: soc_camera: Renesas R-Car VIN driver
Message-Id: <Pine.LNX.4.64.1306260925210.8856@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201306220052.30572.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306220052.30572.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: mchehab@redhat.com, linux-media@vger.kernel.org, magnus.damm@gmail.com, linux-sh@vger.kernel.org, phil.edworthy@renesas.com, matsu@igel.co.jp, vladimir.barinov@cogentembedded.com

Hi Sergei

On Sat, 22 Jun 2013, Sergei Shtylyov wrote:

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Add Renesas R-Car VIN (Video In) V4L2 driver.
> 
> Based on the patch by Phil Edworthy <phil.edworthy@renesas.com>.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: removed deprecated IRQF_DISABLED flag, reordered/renamed 'enum chip_id'
> values, reordered rcar_vin_id_table[] entries,  removed senseless parens from
> to_buf_list() macro, used ALIGN() macro in rcar_vin_setup(), added {} to the
> *if* statement  and used 'bool' values instead of 0/1 where necessary, removed
> unused macros, done some reformatting and clarified some comments.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewing this iteration of the patch is still on my todo, in the meantime 
you might verify whether it works on top of the for-3.11-3 branch of my

http://git.linuxtv.org/gliakhovetski/v4l-dvb.git

git-tree, or "next" after it's been pulled by Mauro and pushed upstream. 
With that branch you shouldn't need any additional patches andy more.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
