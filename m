From: Andrew Stubbs <ams@codesourcery.com>
Date: Mon, 22 Mar 2010 09:44:50 +0000
Subject: Re: codurgery tool chain is on for the kernel for sh2a 7203; but
Message-Id: <4BA73C12.4050009@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003200806.24094.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003200806.24094.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 20/03/10 07:06, Fabio Giovagnini wrote:
> Hi all, the gcc-3.4.6 based toolchain used elf2flt to have the target userspace
> binary.
> What is the model I have to follow?
> Where can I find infos about building toolchain if codesurgery is not suatble?

Wait a while, CodeSourcery will be releasing an SH-2A toolchain in a 
month or so, all being well. It's FDPIC, not FLT though.

Andrew
