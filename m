From: Rob Landley <rob@landley.net>
Date: Fri, 29 Apr 2016 23:22:42 +0000
Subject: Re: [PATCH 7/7] sh: add device tree source for J2 FPGA on Mimas v2 board
Message-Id: <5723ECC2.8020107@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
In-Reply-To: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 04/29/2016 11:06 AM, Rich Felker wrote:
> The main places it might be nice to know about specific cpu versions
> are when new instructions are added, and when there are significances
> in instruction timings that might matter to performance. But both of
> these are cases where we'd probably want a public-facing name of some
> sort (e.g. something like j2-rev2, j2+, ...) and the DT compatible tag
> caan just be aligned with it.

My understanding is that the j2 instruction set is now frozen, j3 gets
frozen sometime next year, and j4 (probably) the year after that.

I believe the pending j4 issues are the rest of sh4 (non-privileged)
instruction support (there's like 6 more instructions? The printout with
the highlighter on it is at the office), 128 bit floating point, and 64
bit integer math.

Jeff was objecting this morning that our j2 is really "j23" (cherry
picking the barrel shifter out of sh3) and our j3 is really "j34"
(cherry picking 64 bit floating point out of sh4), but I really, really,
really don't want to explain that from a branding standpoint. :)

Rob
