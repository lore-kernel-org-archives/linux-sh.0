From: Ian Molton <ian.molton@codethink.co.uk>
Date: Tue, 23 Jul 2013 12:34:24 +0000
Subject: Re: EMEV2: debugging a Strange IRQ issue on SMP
Message-Id: <51EE7850.6010002@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <51ED68B8.3070302@codethink.co.uk>
In-Reply-To: <51ED68B8.3070302@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Update 2:

The problem appears to have been "fixed" by adding a small (5, thus far) 
value to the next timer event to be set, in the sti timer code.

With this hack, I get reliable timer IRQs. I will investigate further 
and submit a patch shortly.

-Ian
