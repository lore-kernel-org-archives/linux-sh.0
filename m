From: Rob Landley <rob@landley.net>
Date: Tue, 31 Jan 2017 20:41:42 +0000
Subject: Re: Bug#576242: gdb: Please support Renesas SH(sh4)
Message-Id: <75e99a89-5e8e-15c4-3729-c692d7a6c3c2@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <c184d5b5-4ec4-96e8-70f0-3ea61ce480db@physik.fu-berlin.de>
In-Reply-To: <c184d5b5-4ec4-96e8-70f0-3ea61ce480db@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/30/2017 05:21 AM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> We're currently working on improving SuperH support in Debian and Linux
> in general since the architecture is currently being redeveloped as an
> open source architecture called J-Core [1]. J-Core supports the SH-2
> instruction set only, but it's expected to extend to SH-3 and SH-4
> in the future. Hence, having working native SH support for gdb on Linux
> would be very desirable.
> 
>>  * Tom Tromey <tromey@redhat.com> pointed out that any significant
>>    contributors would need to sign copyright assignment papers, since
>>    the patch is far from trivial.  Otherwise, GNU won't merge it, and it
>>    will bitrot constantly.
>>    <http://www.cygwin.com/ml/gdb-patches/2011-11/msg00499.html>
> 
> This would actually the first and most important thing to do. I have
> tried contacting Takashi YOSHII but so far I had no success.

I asked the j-core engineers in Japan if they knew him, but the name
didn't ring any bells. (Jeff Dionne might know, but he's busy at
Distributech this week.)

Rob
