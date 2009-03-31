From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Date: Tue, 31 Mar 2009 08:23:18 +0000
Subject: Re: gdbserver on sh4
Message-Id: <49D1D2F6.1000206@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

binom wrote:
> Dear michael ,
> In your reply message it's written that "I fix this problem".
> Can you pl explain what was the problem and and which is the components to
> be updated for incorporating this fix?
> Below given is the details of the host side GDB and target side gdbserver.
>  sh4-linux-gdb --version
> GNU gdb STMicroelectronics/Linux Base 6.5-33 [build Jul 30 2008]
> Copyright (C) 2006 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain
> conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "--host=i686-pc-linux-gnu --target=sh4-linux".
>   
The problem is kernel side and not gdb side. I send a patch to the linux-sh
mailing list. They save the dsp register on the stack before the 
processor cpu register
but the offset of the struct is wrong calculated and if the linux kernel 
is compiled
with the dsp option the PEEKUSR return the wrong register value.

Michael
