From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Date: Wed, 02 Jul 2008 10:42:14 +0000
Subject: Re: [PATCH 06/07] videobuf: Add physically contiguous queue code
Message-Id: <486B5B86.5070807@teltonika.lt>
List-Id: <linux-sh.vger.kernel.org>
References: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>	
	<20080701124735.30446.89320.sendpatchset@rx1.opensource.se>	
	<486B3197.5000100@teltonika.lt>
	<aec7e5c30807020232j1181ba9s43bc0e6920b18733@mail.gmail.com>
In-Reply-To: <aec7e5c30807020232j1181ba9s43bc0e6920b18733@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: video4linux-list@redhat.com
Cc: linux-sh@vger.kernel.org

Magnus Damm wrote:
> On Wed, Jul 2, 2008 at 4:43 PM, Paulius Zaleckas
> <paulius.zaleckas@teltonika.lt> wrote:
>> Heh. I have written almost identical videobuf driver also :)
>> You should run checkpatch.pl on this patch to correct some style
>> problems. Since your version is a little bit more generic than mine:
>>
>> Acked-by: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
> 
> Thanks for your ack. Just curious, which checkpatch version are you
> using? From the linux-next tree? I've checked my patches with the less
> agressive checkpatch included in the linux-2.6 tree. =)

Strange why checkpatch.pl didn't catch this:

+static void *__videobuf_alloc(size_t size)
+{
+	struct videobuf_dma_contig_memory *mem;
+	struct videobuf_buffer *vb;
+
+	vb = kzalloc(size + sizeof(*mem), GFP_KERNEL);
+	if (vb) {
+		mem = vb->priv = ((char *)vb)+size;

Should be	mem = vb->priv = ((char *)vb) + size;

+		mem->magic = MAGIC_DC_MEM;
+	}
+
+	return vb;
+}

