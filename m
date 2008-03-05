From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Wed, 05 Mar 2008 21:59:56 +0000
Subject: Re: Getting probing to work
Message-Id: <1204754396.6467.1.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60803051355s4d498bd2mf9006e9d72409b22@mail.gmail.com>
In-Reply-To: <8b67d60803051355s4d498bd2mf9006e9d72409b22@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Wed, 2008-03-05 at 21:55 +0000, Adrian McMenamin wrote:
> I am working on a device driver for flash (the so-called "Visual
> M
> 
> And the oops appears to be because it is impossible to send messages
> to the device while inside register_driver so the result is that the
> system is flooded with them as soon as the registration fails.
> 

device_register NOT register_driver

sorry

