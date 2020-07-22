From: Rob Landley <rob@landley.net>
Date: Wed, 22 Jul 2020 03:13:13 +0000
Subject: Re: Adding support for SECCOMP_FILTER
Message-Id: <bd4f0ecf-d5f9-ee1e-d58e-85db2fdda25a@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <32f7f7a2-a186-a3cc-0d03-e3380c0d21fc@physik.fu-berlin.de>
In-Reply-To: <32f7f7a2-a186-a3cc-0d03-e3380c0d21fc@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 7/21/20 1:59 PM, John Paul Adrian Glaubitz wrote:
> Hello!
> 
> I recently discovered that the kernel supports seccomp on Linux as support
> was added in 2.6.27 [1].
> 
> I consequently added SH support to libseccomp [2], only to discover that we
> are missing the SECCOMP_FILTER feature. Looking at the changes for PA-RISC [3]
> and RISC-V [4], the necessary changes in the kernel seem to be rather modest.
> 
> Would anyone be willing to help me to implement SECCOMP_FILTER for SH? From what
> I can see, we just need to implement the part to add syscall filtering.

I dunno how much help I'd be (never having used seccomp), but I can try to
reproduce what you do on a second setup? :)

Rob
