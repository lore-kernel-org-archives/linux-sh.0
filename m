From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 08 Aug 2013 20:57:34 +0000
Subject: Re: [PATCH v9] V4L2: soc_camera: Renesas R-Car VIN driver
Message-Id: <5204063E.7050707@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201307260023.11460.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201307260023.11460.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: g.liakhovetski@gmx.de, mchehab@redhat.com, linux-media@vger.kernel.org
Cc: magnus.damm@gmail.com, linux-sh@vger.kernel.org, phil.edworthy@renesas.com, matsu@igel.co.jp, vladimir.barinov@cogentembedded.com

Hello.

On 07/26/2013 12:23 AM, Sergei Shtylyov wrote:

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

> Add Renesas R-Car VIN (Video In) V4L2 driver.

> Based on the patch by Phil Edworthy <phil.edworthy@renesas.com>.

> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: removed deprecated IRQF_DISABLED flag, reordered/renamed 'enum chip_id'
> values, reordered rcar_vin_id_table[] entries,  removed senseless parens from
> to_buf_list() macro, used ALIGN() macro in rcar_vin_setup(), added {} to the
> *if* statement  and used 'bool' values instead of 0/1 where necessary, removed
> unused macros, done some reformatting and clarified some comments.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

    Guennadi, Mauro, if you don't have issues with this version, perhaps we 
still can merge it to 3.11 using "the new drivers can't cause regressions, so 
mergeable any time" rule?

WBR, Sergei

