From: Rob Landley <rob@landley.net>
Date: Sun, 01 Jul 2018 17:27:40 +0000
Subject: Re: [PATCH 4/4] serial: sh-sci: Stop RX FIFO timer during port shutdown
Message-Id: <c3d1884b-baab-241d-e4ee-745ed87dbb3b@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20180629142513.20743-8-geert+renesas@glider.be>
In-Reply-To: <20180629142513.20743-8-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 06/29/2018 09:25 AM, Geert Uytterhoeven wrote:
> The RX FIFO timer may be armed when the port is shut down, hence the
> timer function may still be called afterwards.
> 
> Fix this race condition by deleting the timer during port shutdown.

Will any of this make the qemu-system-sh4 serial console work again?

Rob
