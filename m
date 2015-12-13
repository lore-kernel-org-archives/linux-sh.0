From: Rob Landley <rob@landley.net>
Date: Sun, 13 Dec 2015 22:25:17 +0000
Subject: Re: [PATCH] sh_eth: fix TX buffer byte-swapping
Message-Id: <CAOS_Y6ScbQg-Kh_gNTh2XWKyDEN_uGJt5q1Na5GFDWR9MSbabw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4052048.4A561jYI0l@wasted.cogentembedded.com>
In-Reply-To: <4052048.4A561jYI0l@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Dec 13, 2015 at 12:27 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> For the little-endian SH771x kernels the driver has to byte-swap the RX/TX
> buffers,  however yet unset physcial address from the TX descriptor is used
> to call sh_eth_soft_swap(). Use 'skb->data' instead...

Rummage rummage rummage...

Ah, my sh4 qemu system has an rtl-8139cp network driver, and the sh2
j-core numato board one is A) big endian, B) has an oddball version
with its own driver.

That's why I haven't hit this.

Rob
