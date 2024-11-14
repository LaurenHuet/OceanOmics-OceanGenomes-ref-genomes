# Computational-Biology-OceanOmics/OceanGenomes-refgenomes: Output

## Introduction

This document describes the output produced by the pipeline. Most of the plots are taken from the MultiQC report, which summarises results at the end of the pipeline.

The directories listed below will be created in the results directory after the pipeline has finished. All paths are relative to the top-level results directory.

## Pipeline overview

The pipeline is built using [Nextflow](https://www.nextflow.io/) and processes data using the following steps:

1. Filter and convert bam files to fastq files ([`HiFiAdapterFilt`](https://github.com/sheinasim/HiFiAdapterFilt))
2. PacBio Read QC ([`FastQC`](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/))
3. Count k-mers ([`Meryl`](https://github.com/marbl/meryl))
4. Estimate genome size ([`GenomeScope2`](https://github.com/schatzlab/genomescope))
5. Assemble hifi data ([`Hifiasm`](https://github.com/chhylp123/hifiasm))
6. Assembly stats on hifi data ([`Gfastats`](https://github.com/vgl-hub/gfastats))
7. Illumina Read QC ([`FastQC`](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/))
8. Assemble Pacbio & Illumina reads ([`Hifiasm`](https://github.com/chhylp123/hifiasm))
9. Assembly stats ([`Gfastats`](https://github.com/vgl-hub/gfastats))
10. Gene assembly QC ([`BUSCO`](https://busco.ezlab.org/))
11. K-mer assembly QC ([`Merqury`](https://github.com/marbl/merqury))
12. Create index ([`Samtools`](https://www.htslib.org/))
13. Index assemble and align Hi-C reads ([`BWA`](https://github.com/lh3/bwa))
14. Map pairs ([`Pairtools`](https://pairtools.readthedocs.io/en/latest/))
15. Sort and index ([`Samtools`](https://www.htslib.org/))
16. Create scaffold ([`YAHS`](https://github.com/c-zhou/yahs))
17. Create decontamination report ([`fcs-gx`](https://github.com/ncbi/fcs-gx))
18. Create decontamination report ([`Tiara`](https://github.com/ibe-uw/tiara))
19. Filter decontaminated scaffolds ([`BBMap`](https://jgi.doe.gov/data-and-tools/software-tools/bbtools/bb-tools-user-guide/bbmap-guide/))
20. Scaffold stats ([`Gfastats`](https://github.com/vgl-hub/gfastats))
21. Scaffold QC ([`BUSCO`](https://busco.ezlab.org/))
22. Scaffold QC ([`Merqury`](https://github.com/marbl/merqury))
23. Generate coverage tracks ([`minimap2`](https://github.com/lh3/minimap2))
24. Predict telomere locations ([`tidk`](https://github.com/tolkit/telomeric-identifier))
25. Align reads to scaffolds ([`BWA`](https://github.com/lh3/bwa))
26. Align reads to scaffolds ([`Pairtools`](https://pairtools.readthedocs.io/en/latest/))
27. Generate pretext maps ([`PretextMap`](https://github.com/sanger-tol/PretextMap))
28. Inject coverage tracks into pretext map ([`PretextGraph`](https://github.com/sanger-tol/PretextGraph))
30. Present QC for raw reads ([`MultiQC`](http://multiqc.info/))

### HiFiAdapterFilt

<details markdown="1">
<summary>Output files</summary>

- `hifiadapterfilt/`
  - `sample/`
    - `*.fastq.gz`: filtered hifi fastq files.
    - `*stats`: stat files produced by HiFiAdapterFilt.

</details>

[HiFiAdapterFilt](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-022-08375-1) removes Pacbio adapter contaminated reads from HiFi data and can convert bam files to fastq files.

### Meryl

<details markdown="1">
<summary>Output files</summary>

- `meryl/`
  - `*.hist`: Histogram produced by Meryl.
  - `*.meryldb/`: Meryl database.

</details>

[Meryl](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-020-02134-9) counts k-mers.

### GenomeScope2

<details markdown="1">
<summary>Output files</summary>

- `genomescope2/`
  - `*_model.txt`: Genomescope2 model.
  - `*_summary.txt`: Summary stats.
  - `*.png`: various png files produced by genomescope2.

</details>

[GenomeScope2](https://www.nature.com/articles/s41467-020-14998-3) profiles genomes.

### FastQC

<details markdown="1">
<summary>Output files</summary>

- `fastqc/`
  - `*_fastqc.html`: FastQC report containing quality metrics.
  - `*_fastqc.zip`: Zip archive containing the FastQC report, tab-delimited data file and plot images.

</details>

[FastQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/) gives general quality metrics about your sequenced reads. It provides information about the quality score distribution across your reads, per base sequence content (%A/T/G/C), adapter contamination and overrepresented sequences. For further reading and documentation see the [FastQC help pages](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/).

![MultiQC - FastQC sequence counts plot](images/mqc_fastqc_counts.png)

![MultiQC - FastQC mean quality scores plot](images/mqc_fastqc_quality.png)

![MultiQC - FastQC adapter content plot](images/mqc_fastqc_adapter.png)

### Hifiasm

<details markdown="1">
<summary>Output files</summary>

- `hifiasm/`
  - `*.stderr.log`: Standard error log file produced during the Hifiasm run.
  - `*.gfa`: Various assembly graphs.
  - `*.bin`: Error corrected and overlap reads.

</details>

[Hifiasm](https://www.nature.com/articles/s41592-020-01056-5) assembles genomes.

### BWA

<details markdown="1">
<summary>Output files</summary>

- `bwa/`
  - `*.bam`: bam file produced by BWA.
  - `bwa/`: Directory containing the BWA index of the assembly.

</details>

[BWA](https://pubmed.ncbi.nlm.nih.gov/19451168/) Aligns short reads to a larger reference.

### Pairtools

<details markdown="1">
<summary>Output files</summary>

- `pairtools/`
  - `*.mapped.pairs`: Mapped pairs.
  - `*_dedup.pairs.gz`: Deduplicated pairs.
  - `*_dedup.pairs.stat`: Deduplicated pair stats.
  - `*pairsam.gz`: Parsed pairs.
  - `*pairsam.stat`: Parsed pair stats.
  - `*pairs.gz`: Sorted pairs.
  - `*unsorted.bam`: Unsorted pairs.

</details>

[Pairtools](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9949071/) is a suite of tools for contact extraction from sequencing data.

### Samtools

<details markdown="1">
<summary>Output files</summary>

- `samtools/`
  - `*bam`: Sorted bam file of the Pairtools pairs.
  - `*bai`: Index of the Pairtools pairs.
  - `*fai`: Assembly index.

</details>

[Samtools](https://academic.oup.com/bioinformatics/article/25/16/2078/204688) stores alignment information.

### YAHS

<details markdown="1">
<summary>Output files</summary>

- `yahs/`
  - `*.bin`: Bin file of the haplotypes.
  - `*_scaffolds_final.agp`: AGP file with the scaffolds.
  - `*_scaffolds_final.fa`: Fasta file with the scaffolds.

</details>

[YAHS](https://academic.oup.com/bioinformatics/article/39/1/btac808/6917071) constructs chromose scaffolds.

### fcs-gx

<details markdown="1">
<summary>Output files</summary>

- `fcs/`
  - `out/`
    - `*fcs_gx_report.txt`: Report of the genome.
    - `*.taxonomy.rpt`: Report of the taxonomy assigned to the scaffold.

</details>

[fcs-gx](https://www.biorxiv.org/content/10.1101/2023.06.02.543519v1) decontaminates genomes.

### Tiara

<details markdown="1">
<summary>Output files</summary>

- `tiara/`
  - `*.txt`: Log files and reports.
  - `*.fasta`: Fasta file with flagged scaffolds.

</details>

[Tiara](https://academic.oup.com/bioinformatics/article/38/2/344/6375939) classifies eukaryotic sequences.

### BBMap

<details markdown="1">
<summary>Output files</summary>

- `bbmap/`
  - `*_filtered_scaffolds.fa`: Fasta file with the filtered scaffolds.

</details>

[BBMap](https://escholarship.org/uc/item/1h3515gn) is a suite of tools for working with genomic data.

### Gfastats

<details markdown="1">
<summary>Output files</summary>

- `gfastats/`
  - `*.assembly_summary`: Summary of the assembly and haplotypes.
  - `*.fasta.gz`: Fasta files of the assembly and haplotypes.

</details>

[Gfastats](https://academic.oup.com/bioinformatics/article/38/17/4214/6633308) creates genome summary statistics.

### BUSCO

<details markdown="1">
<summary>Output files</summary>

- `busco/`
  - `*-busco.batch_summary.txt`: Summary file.
  - `*-busco/`: Busco directory containing scaffolds and logs.
  - `*_busco_figure.png`: Plot generated by BUSCO.
  - `*.json`: Json file fith summary.
  - `*.txt`: Txt file with summary.

</details>

[BUSCO](https://academic.oup.com/mbe/article/38/10/4647/6329644) assesses genome quality.

### Merqury

<details markdown="1">
<summary>Output files</summary>

- `merqury/`
  - `*.png`: Various plots produced my Merqury.
  - `*.hist`: kmer count tables.
  - `*.qv`: Qv stats.
  - `*.bed`: Bed files of the scaffolds and haplotypes.
  - `*.wig`: Wig file of the scaffolds and haplotypes.
  - `*.ploidy`: Ploidy count table.
  - `*.stats`: Completeness stats.

</details>

[Merqury](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-020-02134-9) assesses genome quality.

### MultiQC

<details markdown="1">
<summary>Output files</summary>

- `multiqc/`
  - `multiqc_report.html`: a standalone HTML file that can be viewed in your web browser.
  - `multiqc_data/`: directory containing parsed statistics from the different tools used in the pipeline.
  - `multiqc_plots/`: directory containing static images from the report in various formats.

</details>

[MultiQC](http://multiqc.info) is a visualization tool that generates a single HTML report summarising all samples in your project. Most of the pipeline QC results are visualised in the report and further statistics are available in the report data directory.

Results generated by MultiQC collate pipeline QC from supported tools e.g. FastQC. The pipeline has special steps which also allow the software versions to be reported in the MultiQC output for future traceability. For more information about how to use MultiQC reports, see <http://multiqc.info>.

### Pipeline information

<details markdown="1">
<summary>Output files</summary>

- `pipeline_info/`
  - Reports generated by Nextflow: `execution_report.html`, `execution_timeline.html`, `execution_trace.txt` and `pipeline_dag.dot`/`pipeline_dag.svg`.
  - Reports generated by the pipeline: `pipeline_report.html`, `pipeline_report.txt` and `software_versions.yml`. The `pipeline_report*` files will only be present if the `--email` / `--email_on_fail` parameter's are used when running the pipeline.
  - Reformatted samplesheet files used as input to the pipeline: `samplesheet.valid.csv`.
  - Parameters used by the pipeline run: `params.json`.

</details>

[Nextflow](https://www.nextflow.io/docs/latest/tracing.html) provides excellent functionality for generating various reports relevant to the running and execution of the pipeline. This will allow you to troubleshoot errors with the running of the pipeline, and also provide you with other information such as launch commands, run times and resource usage.
