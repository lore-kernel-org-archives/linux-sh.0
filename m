From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 09 Jul 2013 12:21:00 +0000
Subject: Re: [RFC][PATCH] ARM: shmobile: bockw: add DT reference
Message-Id: <51DC002C.5030505@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761wkt9q0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761wkt9q0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 09-07-2013 12:32, Kuninori Morimoto wrote:

> This patch adds a sample DT-based Bock-W "reference" implementation.
> The use of platform-specific C-code should be avoided
> with this configuration as much as possible.

    I don't quite understand why you've made BOCK-W bootable only with 
DT in the first place if you're now also making the reference platform 
for it.

> This patch adds new r8a7778_add_dt_devices() which was same stance
> of r8a7790_add_dt_devices()

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

WBR, Sergei

