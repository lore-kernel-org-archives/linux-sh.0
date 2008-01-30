From: "Ha Nguyen" <hanguytv@gmail.com>
Date: Wed, 30 Jan 2008 15:37:55 +0000
Subject: Re: mem-to-mem copy using fdma ...
Message-Id: <4d014b890801300737s227fee89n6e9e086112805eb4@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4d014b890801300132g48a88a0ejb3a64ebe697d3835@mail.gmail.com>
In-Reply-To: <4d014b890801300132g48a88a0ejb3a64ebe697d3835@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Jan 30, 2008 2:38 PM, Stuart MENEFY <stuart.menefy@st.com> wrote:
> Hi Ha
>
> Ha Nguyen wrote:
> > I have to read UDP packets from sk_buff to my module in kernel space
> > and the udp stack uses copy_to_user() to do my task.
>
> I'm not sure what you're doing here. Do you mean you have kernel code
> which is calling sys_recv()? In which case your code would never have
> any visibility of the sk_buff.

The kernel module I'm working on calls kernel_recvmsg() to read
packets from the socket. What I want to do, as you guessed before, is
to optimize the copy_to_user() using fdma for memory copying.

I remembered I read something about the Intel IOAT implementation, my
impression was that it is only TCP while my data is UDP-based. But I
might miss somewhere, will search and look at it again.

>
> As was mentioned a few days ago, once the dmaengine API is in place,
> this should be a much easier experiment to try.

That's great, when do you expect the dmaengine would be available?

> The DMA code for the ST40 based chips is very specific, so you're
> better off posting questions about that to the STLinux bugzilla
> (bugzilla.stlinux.com). However the 2.6.17 kernel is from the 2.2
> distribution, so you shouldn't be using the FDMA legacy documentation.
> The slightly more up to date documentation is at:
> http://www.stlinux.com/docs/manual/distribution/distribution_guide14.php
>
> But your best be would be to look at one of the existing drivers which
> uses the FDMA, such as the IDE PIO-DMA or ALSA.
>
> Stuart
>

Thank you for a great input!
/ha
