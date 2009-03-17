From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Tue, 17 Mar 2009 14:43:18 +0000
Subject: Re: On "sh: Consolidate SH-Mobile CPU code in arch/sh/kernel/cpu/shmobile/."
Message-Id: <49BFB706.8020004@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49BF4B7C.2090607@st.com>
In-Reply-To: <49BF4B7C.2090607@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
>
> Sure. Let's do it step by step. I like the idea of some kind of
> interpreter, but I was hoping on that we can agree on something a bit
> simpler.
If possible why not
>
> My main question is: Do you really need to be able to load and save
> data from the interpreter?
This isn't really a problem or an issue.
The current code work mainly with only 2 tables:
 - an instruction table
 - a resource table

The resource table is an array of base address of usable resource, it 
doesn't matter what the resource is... each
 resource can be hw or memory... the writable table (in my convention) 
is only the first element of
 ioresource table.

For this reason in the interpreter there is no real instruction 'data' 
oriented...
Each interpreter instruction works with the i-th element of an k-th 
ioresources.

In the code I have only to be care the 'writable' table is in Dcache... 
but after that
 for the interpreter point of vie the writable table and an hw-resource 
are perfectly equivalent.

>
> Right now your implementation has multiple tables.

>  I'd prefer to just
> generate a bunch of inline operations that we either load into the
> cache or put in on-chip ram depending on processor type. Each
> operation would be self-contained.
I agree and for this reason I wrote several macros on top of 
instructions to simplify the
 table creation, but I'd like maintain the current granularity because 
'ad-hoc' instruction
 could be too much hw dependent and we could need to add other asm code 
to support
 any new hw... While with this instruction granularity a new hw means at 
least
 some other macro to build the right instruction the new hw needs.
>
> What are your requirements?
In the ST40 we have no ipref instruction and in the latest version it 
was removed the
 RAM mode cache support.
Therefore the code has to be preloaded in Icache with the jumper 
mechanism I did (other suggestion?)
Moreover I don't want set constraint on how many resource the 
interpreter can use.
This means that the interpreter should be able to manage (teorically) 
any hw resource not only the dram,
 for example I strongly need access the Clocks-IP.

Regards
 Francesco
