From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 18 Mar 2009 10:34:46 +0000
Subject: Re: [PATCH] sh: simplify kexec vbr code V2
Message-Id: <20090318103446.GA7391@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090318084731.5923.41436.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090318084731.5923.41436.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 18, 2009 at 05:47:31PM +0900, Magnus Damm wrote:
> Setup the vbr register in machine_kexec() V2. This
> instead of passing values to the assembly snippet.

On Wed, Mar 18, 2009 at 05:49:45PM +0900, Magnus Damm wrote:
> Rework the kexec code to avoid using P2SEG. Instead
> we walk the page list in machine_kexec() and convert
> the addresses from physical to virtual using C.

On Wed, Mar 18, 2009 at 05:51:29PM +0900, Magnus Damm wrote:
> Add kexec jump support to the SuperH architecture V2.
> 
> Similar to the x86 implementation, with the following
> exceptions:
> 
> - Instead of separating the assembly code flow into
> two parts for regular kexec and kexec jump we use a
> single code path. In the assembly snippet regular
> kexec is just kexec jump that never comes back.
> 
> - Instead of using a swap page when moving data between
> pages the page copy assembly routine has been modified
> to exchange the data between the pages using registers.
> 
> - We walk the page list twice in machine_kexec() to
> do and undo physical to virtual address conversion.

Applied with a few fixups, including ftrace state save/restore.
