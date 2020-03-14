From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 14 Mar 2020 10:59:44 +0000
Subject: Re: [RESEND PATCH v2 6/9] drm/mgag200: Constify ioreadX() iomem argument (as in generic implementati
Message-Id: <20200314105944.GA16044@kozik-lap>
List-Id: <linux-sh.vger.kernel.org>
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-7-krzk@kernel.org>
 <90baef2d-25fe-fac4-6a7e-b103b4b6721e@suse.de>
In-Reply-To: <90baef2d-25fe-fac4-6a7e-b103b4b6721e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Jason Wang <jasowang@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, netdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>, Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, Nick Kossifidis <mickflemm@gmail.com>, Allen Hubbe <allenbh@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, Richard Henderson <rth@twiddle.net>, linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>, linux-media@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Thu, Mar 12, 2020 at 11:49:05AM +0100, Thomas Zimmermann wrote:
> Hi Krzysztof,
> 
> I just received a resend email from 3 weeks ago :/
> 
> Do you want me to merge the mgag200 patch into drm-misc-next?

Thanks but it depends on the first patch in the series so either it
could go with your ack through other tree or I will send it later (once
1st patch gets to mainline).


Best regards,
Krzysztof
