From: Simon Horman <horms@verge.net.au>
Date: Tue, 04 Jun 2013 01:33:09 +0000
Subject: Re: [PATCH v3 1/1] ARM: shmobile: r8a7778: add I2C support
Message-Id: <20130604013309.GI23054@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201304232012.57619.sergei.shtylyov@cogentembedded.com>
 <201304232015.59697.sergei.shtylyov@cogentembedded.com>
 <51AB9474.3040900@cogentembedded.com>
In-Reply-To: <51AB9474.3040900@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Jun 02, 2013 at 10:52:36PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 04/23/2013 08:15 PM, Sergei Shtylyov wrote:
> 
> >From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >
> >Add I2C clocks and platform devices for R8A7778 SoC.
> >Don't forget to also add the peripheral clock which the I2C driver uses.
> >
> >Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >[Sergei: changed the registration function to platform_device_register_simple(),
> >annotated I2C resources as '__initdata', regrouped MSTPxxx *enum* members, added
> >the copyright.]
> >Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
>    Simon, I'm calling back this patch. Morimoto-san's patch posted recently
> (preferably to be reposted once more) should be used instead.

Thanks, noted.
