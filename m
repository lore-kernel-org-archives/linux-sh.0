From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 08 Feb 2009 17:29:38 +0000
Subject: Re: oops I get on booting
Message-Id: <1234114178.6673.1.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1233967281.6893.3.camel@localhost.localdomain>
In-Reply-To: <1233967281.6893.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, 2009-02-07 at 00:41 +0000, Adrian McMenamin wrote:
> I am getting this error every so often on boot -as it is not every time
> it seems to be a race condition of some sort. With the latest git the
> frequency of the problem seems to have increased, but it has been there
> for a while.
> 
> Anybody have any suggestions as to what it might be? Naturally I'd
> suspect my own code, though nothing I've written is in the stack:
> 
> [   42.893155] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> [   42.909100] pc = 8c0874ea

I think I've identified the source of this - some memory corruption in
my code that was causing oopses elsewhere. A patch to follow.

