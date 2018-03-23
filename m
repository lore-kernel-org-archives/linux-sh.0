From: NIIBE Yutaka <gniibe@fsij.org>
Date: Fri, 23 Mar 2018 02:09:30 +0000
Subject: Re: Moving forward with gdb sh native support?
Message-Id: <871sgbr19h.fsf@iwagami.gniibe.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20180322013659.GA8118@brightrain.aerifal.cx>
In-Reply-To: <20180322013659.GA8118@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
> FWIW, Yutaka Niibe has managed to determine the original author of the
> SH patchset and it turns out this was not Takashi Yoshii who wrote the
> patch but Toshinobu Sugioka. Yutaka has contacted him and asked him
> to sign the copyright assignment for GDB. So, with me and Toshinobu
> having signed the copyright assignment, it should now be possible to
> get my out-of-tree patch merged upstream to GDB.

Mostly 20 years ago, if I remember correctly, it was me who implemented
the ptrace syscall in SuperH kernel, and put something to GDB for native
debugging.  It was under the GNU/Linux for SuperH Project.  Me, Kaz
Kojima, Toshinobu Sugioka, and Takashi Yoshii were all working together
at that time.

Before the ptrace system call, or any part of the kernel, as a start, I
wrote my own initial program loader for SuperH which has GDB serial
debug support.  Then, I ported the kernel to SH-3.  After my first
submission of the patch to lkml, I realized that Kaz, Toshinobu, and
Stuart Menefy were also having their own ports of SuperH.  I managed to
merge all efforts.

I and Kaz designed the shared object ABI for SuperH, and implemented in
glibc, gcc, binutils, and GDB.  For all of GNU toolchain changes and
glibc, I assigned my copyright to FSF.  So did Kaz Kojima.

After that, it was Toshinobu Sugioka who kept working the GDB patchset,
as well as other patches to distribute his own RPM based distribution.

Last year, I determined that the GDB patchset (of Adrian) was originally
came from Toshinobu Sugioka, via Takashi Yoshii.  So, I asked his
copyright assignment to FSF.  He did.  It was handled with the ticket of
[gnu.org #1227959].  I received the confrmation from FSF, in the
message of:

	Date: Wed, 26 Jul 2017 10:06:13 -0400
	Message-ID: <rt-4.2.13-5-gc649048-17168-1501077972-1368.1227959-6-0@rt.gnu.org>

... which was also sent to GDB maintainers.
-- 
