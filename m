From: Rob Landley <rob@landley.net>
Date: Mon, 02 Jul 2018 19:01:08 +0000
Subject: Re: [PATCH 4/4] serial: sh-sci: Stop RX FIFO timer during port shutdown
Message-Id: <b5e03d7d-d7d5-4e31-5d9a-036521f30ff5@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20180629142513.20743-8-geert+renesas@glider.be>
In-Reply-To: <20180629142513.20743-8-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 07/02/2018 04:50 AM, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Sun, Jul 1, 2018 at 7:27 PM Rob Landley <rob@landley.net> wrote:
>> On 06/29/2018 09:25 AM, Geert Uytterhoeven wrote:
>>> The RX FIFO timer may be armed when the port is shut down, hence the
>>> timer function may still be called afterwards.
>>>
>>> Fix this race condition by deleting the timer during port shutdown.
>>
>> Will any of this make the qemu-system-sh4 serial console work again?
> 
> Probably not, as none of these patches touch the qemu source tree.

So we remain well into the second year of each project pointing the finger at
the other on this, and nothing getting fixed. And the workaround remains "run a
kernel from before February 2017 if you want a working serial console under qemu.

Good to know,

Rob
