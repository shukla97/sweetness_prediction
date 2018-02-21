import pandas as pd
df = pd.read_csv("gdb_data.csv")
k = 0
for i in df["smiles"]:
    k = k+1
    z = str(k)
    file= open(z + ".smi","w")
    file.write(str(i))
    file.close()
