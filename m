From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Thu, 12 Mar 2020 08:01:22 +0000
Subject: Re: [RESEND PATCH v2 8/9] media: fsl-viu: Constify ioreadX() iomem argument (as in generic implement
Message-Id: <1c4a11b5-5ca6-7555-de3c-ff30f707fac7@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-9-krzk@kernel.org>
In-Reply-To: <20200219175007.13627-9-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-media@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org, linux-arch@vger.kernel.org

On 2/19/20 6:50 PM, Krzysztof Kozlowski wrote:
> The ioreadX() helpers have inconsistent interface.  On some architectures
> void *__iomem address argument is a pointer to const, on some not.
> 
> Implementations of ioreadX() do not modify the memory under the address
> so they can be converted to a "const" version for const-safety and
> consistency among architectures.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> ---
>  drivers/media/platform/fsl-viu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
> index 81a8faedbba6..991d9dc82749 100644
> --- a/drivers/media/platform/fsl-viu.c
> +++ b/drivers/media/platform/fsl-viu.c
> @@ -34,7 +34,7 @@
>  /* Allow building this driver with COMPILE_TEST */
>  #if !defined(CONFIG_PPC) && !defined(CONFIG_MICROBLAZE)
>  #define out_be32(v, a)	iowrite32be(a, (void __iomem *)v)
> -#define in_be32(a)	ioread32be((void __iomem *)a)
> +#define in_be32(a)	ioread32be((const void __iomem *)a)
>  #endif
>  
>  #define BUFFER_TIMEOUT		msecs_to_jiffies(500)  /* 0.5 seconds */
> 
