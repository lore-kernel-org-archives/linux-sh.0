From: Rob Landley <rob@landley.net>
Date: Mon, 15 May 2017 18:16:37 +0000
Subject: Re: QEMU serial still broken in -rc1.
Message-Id: <8f03278a-6769-30e4-20c7-a13416cfe06e@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
In-Reply-To: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 05/15/2017 12:13 AM, John Paul Adrian Glaubitz wrote:
> On 05/15/2017 07:11 AM, John Paul Adrian Glaubitz wrote:
>> They do fix bugs but they often take some time to work through the
>> patch queue because they usually get a larger number of patches [1].
> 
> Oh, and Aurelien Jarno has pushed a larger number of SH-related fixes [1].
> 
> Adrian
> 
>> [1] https://patchwork.ozlabs.org/patch/761962/

Hmmm, I should poke him about attempting to get j-core SOC support and
sh2 cpu emulation working. And the whole "qemu-system-sh4" naming when
there's sh2 and sh3... (Also, why does QEMU _not_ support the -kernel
vmlinux ELF loader on all boards? In theory that's reasonably generic...)

Rob
