From: Ian Molton <ian.molton@codethink.co.uk>
Date: Tue, 23 Jul 2013 10:53:16 +0000
Subject: Re: EMEV2: debugging a Strange IRQ issue on SMP
Message-Id: <51EE609C.6000304@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <51ED68B8.3070302@codethink.co.uk>
In-Reply-To: <51ED68B8.3070302@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 22/07/13 18:15, Ian Molton wrote:
> Hi guys,
>
> I'm currently attempting to debug strange interrupt handling behaviour 
> on EMEV2.
>
> I and Ben Dooks undertook a port of much of the EMEV2 (mach-emxx) to 
> 2.6.39 a couple of weeks ago, and I recall having dealt with similar 
> problems before, although they went away with some patches that fixed 
> the pl310 cache controller behaviour.
>
Update: I am seeing this periodically with nosmp - about one in every 10 
boots.

-Ian
